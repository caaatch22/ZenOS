#include "common/common.h"
#include "arch/hw.h"
#include "arch/riscv.h"
#include "proc/proc.h"
#include "proc/elf.h"
#include "fs/vfs.h"
#include "mm/pmallocator.h"
#include "mm/vm.h"
#include "mm/usrmm.h"
#include "utils/string.h"
#include "trap/trap.h"

#define MAXARG       32  // max exec arguments
#define MAXENV        8  // max execve envs

extern uint64_t *access_addr(struct proc *p, pagetable_t pg, uint64_t addr);
// static void
// print_ustack(pagetable_t pgtbl){
//   // uint64_t *pa;
//   // uint64_t *va;
//   // for(va = (uint64_t *)(VUSTACK)-1; (uint64_t)va > sp; va--){
//   //   pa = (uint64_t *)walkaddr(pgtbl, (uint64_t)va);
//   //   print("%p\n", *pa);
//   // }
//   print("=============USER STACK============\n");
//   uint64_t *buf = allocpage();
//   copyin(pgtbl, (char *)buf, VUSTACK-PAGE_SIZE, PAGE_SIZE);
//   for(int i= PAGE_SIZE/8; i > PAGE_SIZE/16; i--){
//     print("%p\n", buf[i]);
//   }
//   print("=============OVER============\n");
//   pm_free((void *)buf);
// }


// Load a program segment into pagetable at virtual address va.
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64_t va, struct inode *ip, uint32_t offset, uint32_t sz)
{

  if(va % PAGE_SIZE != 0){
    sz += va - PAGE_ROUNDDOWN(va);
    offset = PAGE_ROUNDDOWN(offset);
    va = PAGE_ROUNDDOWN(va);
  }

  LOG_DEBUG("off:%d sz:%d ipname:%s", offset, sz, ip->entry->name );

  uint32_t i, n;
  uint64_t pa;
  if((va % PAGE_SIZE) != 0)
    PANIC("loadseg: va must be page aligned");

  for(i = 0; i < sz; i += PAGE_SIZE) {
    uint64_t *pte = pte_fetch(pagetable, va + i);
    pa = va2pa(pagetable, va);
    // uint64_t pa1 = PTE2PA_PPN(*pte);
    // LOG_DEBUG("%d", pa == pa1);
    // pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      PANIC("loadseg: address should exist");
    if(sz - i < PAGE_SIZE)
      n = sz - i;
    else
      n = PAGE_SIZE;
    // LOG_DEBUG("i:%d, n:%d filesize:%d", i, n, ip->size);
    if (ip->fop->read(ip, 0, (uint64_t)pa, offset + i, n) != n)
      return -1;
  }


  return 0;
}

// push arg or env strings into user stack, return strings count
static int pushstack(pagetable_t pt, uint64_t table[], char **utable, int maxc, uint64_t *spp)
{
  LOG_DEBUG("utable: %p", utable);
  uint64_t sp = *spp;
  uint64_t stackbase = PAGE_ROUNDDOWN(sp);
  uint64_t argc, argp;
  char *buf;

  if ((buf = pm_alloc()) == NULL) {
    LOG_ERROR("allocpage==NULL\n");
    return -1;
  }

  for (argc = 0; utable; argc++) {
    LOG_DEBUG("utable: %p", utable);
    if (argc >= maxc || fetchaddr((uint64_t)(utable + argc), &argp) < 0){
      LOG_ERROR("fetchaddr wrong\n");
      goto bad;
    }
    if (argp == 0)
      break;
    int arglen = fetchstr(argp, buf, PAGE_SIZE);   // '\0' included in PAGE_SIZE, but not in envlen
    if (arglen++ < 0) {                               // including '\0'
      LOG_ERROR("didn't get null\n");
      goto bad;
    }
    sp -= arglen;
    sp -= sp % 16;
    if (sp < stackbase || copyout(pt, sp, buf, arglen) < 0){
      LOG_ERROR("copyout wrong\n");
      goto bad;
    }
    table[argc] = sp;
  }
  table[argc] = 0;
  *spp = sp;
  pm_free(buf);
  return argc;

bad:
  if (buf)
    pm_free(buf);
  return -1;
}

// All argvs are pointers came from user space, and should be checked by sys_caller
int execve(char *path, char **argv, char **envp)
{
  LOG_DEBUG("argv: %p", argv);
  struct inode *ip = NULL;
  uint64_t elf_entryInMem = 0;  // The first seg's start address in mem
  pagetable_t pagetable = NULL;
  struct seg *seghead = NULL, *seg;
  struct proc *p = curr_proc();

//   // XXX : we should mount "/bin" on "/"
//   if(strncmp("/sbin/", (const char *)path, 6) == 0){
//     strcpy(path, path+5);
//   }
  //__debug_info("exec", "execve %s", path);

  if ((ip = namei(path)) == NULL) {
    //__debug_warn("execve", "can't open %s\n", path);
    print("in exec:can not find file from path:%s\n", path);
    goto bad;
  }

  // Make a copy of p->pagetable without old user space,
  // but with the same kstack we are using now, which can't be changed.
  if ((pagetable = (pagetable_t)pm_alloc()) == NULL)
    goto bad;
  memmove(pagetable, p->pagetable, PAGE_SIZE);
  // Remove old u-map from the new pt, but don't free since later op might fail.
  // MAXUVA 0x80000000
  for (int i = 0; i < VA_VPN_FETCH(0x80000000, 1); i++) {
    pagetable->page_entry[i] = 0;
  }

  ilock(ip);

  // Check ELF header
  struct elfhdr elf;
  if (ip->fop->read(ip, 0, (uint64_t) &elf, 0, sizeof(elf)) != sizeof(elf) || elf.magic != ELF_MAGIC){
    iunlock(ip);
    LOG_ERROR("read elf_head fail\n");
    goto bad;
  }

  // Load program into memory.
  struct proghdr ph;
  int flags;
  for (int i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    if (ip->fop->read(ip, 0, (uint64_t)&ph, off, sizeof(ph)) != sizeof(ph)) {
     // __debug_warn("execve", "fail to read ELF file\n");
      LOG_ERROR("read ph fail\n");
      iunlock(ip);
      goto bad;
    }
    if (ph.type != ELF_PROG_LOAD)
      continue;
    //if (ph.vaddr % PAGE_SIZE != 0 || ph.memsz < ph.filesz || ph.vaddr + ph.memsz < ph.vaddr) {
    if ( ph.memsz < ph.filesz || ph.vaddr + ph.memsz < ph.vaddr ) {
      //__debug_warn("execve", "funny ELF file: va=%p msz=0x%x fsz=0x%x\n", ph.vaddr, ph.memsz, ph.filesz);
      print("address not align\n");
      iunlock(ip);
      goto bad;
    }

    if (ph.off == 0){
      elf_entryInMem = ph.vaddr;  // For later AUX stack
    }

    // turn ELF flags to PTE flags
    flags = 0;
    flags |= (ph.flags & ELF_PROG_FLAG_EXEC) ? PTE_X : 0;
    flags |= (ph.flags & ELF_PROG_FLAG_WRITE) ? PTE_W : 0;
    flags |= (ph.flags & ELF_PROG_FLAG_READ) ? PTE_R : 0;

    seg = newseg(pagetable, seghead, LOAD, ph.vaddr, ph.memsz, flags);

    if(seg == NULL) {
      print("loadseg: alloc newseg fail\n");
      iunlock(ip);
      goto bad;
    }

    seghead = seg;
    if (loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    {
      print("loadseg fail\n");
      iunlock(ip);
      goto bad;
    }
  }

  char pname[16];
  safestrcpy(pname, ip->entry->name, sizeof(pname));
  iunlock(ip);
  //iput(ip);


  // Heap
  flags = PTE_R | PTE_W;
  for (seg = seghead; seg->next != NULL; seg = seg->next);

  uint64_t brk = PAGE_ROUNDUP(seg->addr + seg->sz);
  seg = newseg(pagetable, seghead, HEAP, brk, 0, flags);
  if(seg == NULL) {
    print("heap: alloc newseg fail\n");
    goto bad;
  }
  seghead = seg;

  // Stack
  #define VUSTACK_SIZE (10 * PAGE_SIZE)
  seg = newseg(pagetable, seghead, STACK, VUSTACK - VUSTACK_SIZE, VUSTACK_SIZE, flags);
  if(seg == NULL) {
    //__debug_warn("execve", "new stack fail\n");
    print("stack: alloc newseg fail\n");
    goto bad;
  }
  seghead = seg;

  /* If the stack is located, we can assign sp */
  uint64_t sp = VUSTACK;
  uint64_t stackbase = VUSTACK - PAGE_SIZE;

  sp -= sizeof(uint64_t);
  //sp -= sp % 16;        // on risc-v, sp should be 16-byte aligned

  // arguments to user main(argc, argv, envp)
  // argc is returned via the system call return
  // value, which goes in a0.
  long long argc, envc;
  uint64_t uargv[MAXARG + 1], uenvp[MAXENV + 1];
  LOG_DEBUG("argv: %p", argv);
  if ((envc = pushstack(pagetable, uenvp, envp, MAXENV, &sp)) < 0 ||
      (argc = pushstack(pagetable, uargv, argv, MAXARG, &sp)) < 0) {
    //__debug_warn("execve", "fail to push argv or envp into user stack\n");
    LOG_DEBUG("push arg & env wrong\n");
    goto bad;
  }

  uint64_t random[2] = { 0xcde142a16cb93072, 0x128a39c127d8bbf2 };
	sp -= 16;
	if (sp < stackbase || copyout(pagetable, sp, (char *)random, 16) < 0) {
    print("push random wrong\n");
		goto bad;
	}

	uint64_t auxvec[][2] = {
		// {AT_HWCAP, 0x112d},
		{AT_PAGESZ, PAGE_SIZE},
		{AT_PHDR, elf.phoff + elf_entryInMem},
		{AT_PHENT, elf.phentsize},
		{AT_PHNUM, elf.phnum},
		{AT_UID, 0},
		{AT_EUID, 0},
		{AT_GID, 0},
		{AT_EGID, 0},
		{AT_SECURE, 0},
		{AT_RANDOM, sp},
		{AT_NULL, 0}
	};

  sp -= sizeof(auxvec) + 16;
  uint64_t auxvec_addr = sp;
  sp -= (envc + 1) * sizeof(uint64_t);
  uint64_t uenvp_addr = sp;
  sp -= (argc + 1) * sizeof(uint64_t);
  uint64_t uargv_addr = sp;
  sp -= sizeof(uint64_t);

  // risc-v needs 16-byte align
  flags = sp % 16;  // flags is useless here, we borrow it
  auxvec_addr -= flags;
  uenvp_addr -= flags;
  uargv_addr -= flags;
  sp -= flags;

  //__debug_info("execve", "pushing argv/envp table\n");
  if (sp < stackbase ||
      copyout(pagetable, auxvec_addr, (char *)auxvec, sizeof(auxvec)) < 0 ||
      copyout(pagetable, uenvp_addr, (char *)uenvp, (envc + 1) * sizeof(uint64_t)) < 0 ||
      copyout(pagetable, uargv_addr, (char *)uargv, (argc + 1) * sizeof(uint64_t)) < 0 ||
      copyout(pagetable, sp, (char *)&argc, sizeof(uint64_t)) < 0)
  {
    //__debug_warn("execve", "fail to copy argv/envp table into user stack\n");
    print("copy argn wrong\n");
    goto bad;
  }
  p->trapframe->a1 = sp;
  p->trapframe->a2 = uenvp_addr;

  // print_ustack(pagetable);

  // Save program name for debugging.
  memmove(p->name, pname, sizeof(p->name));

  // Commit to the user image.
  pagetable_t oldpagetable = p->pagetable;
  seg = p->segment;
  p->program_break = brk;
  p->pagetable = pagetable;
  p->segment = seghead;
  p->trapframe->epc = elf.entry;  // initial program counter = main
  p->trapframe->sp = sp; // initial stack pointer

  if (p->elf)  // 这里由于要更换elf，就必须先iput之前的elf
    iput(p->elf);
  p->elf = ip;

  w_satp(MAKE_SATP(p->pagetable));
  w_sstatus_fs(SSTATUS_FS_CLEAN);
  sfence_vma();

  // if(NULL == access_addr(p, pagetable, 0x802049cf)){
  //   print("pid:%d, wrong pgt\n", p->pid);
  // }

  delsegs(oldpagetable, seg);
  uvmfree(oldpagetable);
  pm_free(oldpagetable);

  //return argc; // this ends up in a0, the first argument to main(argc, argv)
  return 0;

 bad:

  if (seghead) {
    delsegs(pagetable, seghead);
  }
  if (pagetable) {
    uvmfree(pagetable);
    pm_free(pagetable);
  }
  if (ip) {
    //iunlock(ip);
    iput(ip);
  }

  LOG_ERROR("something wrong\n");
  return -1;
}
