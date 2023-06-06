#include "trap/trap.h"
#include "arch/riscv.h"
#include "arch/hw.h"
#include "proc/proc.h"
#include "syscall/syscall.h"

extern char trapforward[], uservec[], userret[];
extern void kernelvec();

void trapinit_hart() {
  set_kerneltrap();
  w_sie(r_sie() | SIE_SEIE | SIE_SSIE);
}

void trapinit() { }


// set up to take exceptions and traps while in the kernel.
void set_usertrap(void) {
  intr_disable();
  w_stvec(((uint64_t)TRAPFORWARD + (uservec - trapforward)) & ~0x3); // DIRECT
}

void set_kerneltrap(void) {
  w_stvec((uint64_t)kernelvec & ~0x3); // DIRECT
  intr_enable();
}

void kernel_interrupt_handler(uint64_t scause, uint64_t stval, uint64_t sepc) {
  uint64_t cause = scause & 0xff;
  int irq;
  switch (cause) {
  case SupervisorTimer:
    // TODO
    break;
  case SupervisorExternal:
    // TODO
    break;
  default:
    LOG_ERROR("unknown kernel interrupt: %p, sepc=%p, stval = %p\n", scause, sepc, stval);
    PANIC("kernel interrupt");
    break;
  }
}

void user_exception_handler(uint64_t scause, uint64_t stval, uint64_t sepc) {
  struct proc *p = curr_proc();
  struct trapframe *trapframe = p->trapframe;
  switch (scause & 0xff) {
  case UserEnvCall:
    // if (p->killed)
    //   exit(-1);
    trapframe->epc += 4;
    intr_enable();
    syscall();
    break;
  case StoreAccessFault:
    LOG_INFO("StoreAccessFault in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-8);
    break;
  case StorePageFault:
    LOG_INFO("StorePageFault in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-7);
    break;
  case InstructionAccessFault:
    LOG_INFO("InstructionAccessFault in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-6);
    break;
  case InstructionPageFault:
    LOG_INFO("InstructionPageFault in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-5);
    break;
  case LoadAccessFault:
    LOG_INFO("LoadAccessFault in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-4);
    break;
  case LoadPageFault:
    LOG_INFO("LoadPageFault in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-2);
    break;
  case IllegalInstruction:
    LOG_ERROR("IllegalInstruction in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-3);
    break;
  default:
    LOG_ERROR("Unknown exception in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-1);
    break;
  }
}

void user_interrupt_handler(uint64_t scause, uint64_t stval, uint64_t sepc) {
  int irq;
  switch (scause & 0xff) {
  case SupervisorTimer:
    // TODO
    break;
  case SupervisorExternal:
    // TODO
    break;
  default:
    LOG_ERROR("Unknown interrupt in user application: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    exit(-1);
    break;
  }
}

//
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void usertrap() {
  uint64_t sepc = r_sepc();
  uint64_t sstatus = r_sstatus();
  uint64_t scause = r_scause();
  uint64_t stval = r_stval();

  ASSERT(!intr_get(), "");
  // debugcore("Enter user trap handler scause=%p", scause);

  w_stvec((uint64_t)kernelvec & ~0x3); // DIRECT
  // debugcore("usertrap");
  // print_cpu(mycpu());

  ASSERT((sstatus & SSTATUS_SPP) == 0, "usertrap: not from user mode");

  if (scause & (1ULL << 63)) { // interrput = 1
    user_interrupt_handler(scause, stval, sepc);
  } else { // interrput = 0
    user_exception_handler(scause, stval, sepc);
  }

  usertrapret();
}

//
// return to user space
//
void usertrapret() {
  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  
  // intr_off();
  set_usertrap();
  struct trapframe *trapframe = curr_proc()->trapframe;
  trapframe->kernel_satp = r_satp(); // kernel page table
  // LOG_DEBUG("xxxx curr_pid %d", curr_proc()->pid);
  trapframe->kernel_sp = curr_proc()->kstack + PAGE_SIZE; // process's kernel stack
  trapframe->kernel_trap = (uint64_t)usertrap;
  trapframe->kernel_hartid = r_tp(); // hartid for cpuid()
  // LOG_DEBUG("epc=%p",trapframe->epc);
  w_sepc(trapframe->epc);
  // set up the registers that trampoline.S's sret will use
  // to get to user space.

  // set S Previous Privilege mode to User.
  uint64_t x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
  x |= SSTATUS_SPIE; // enable interrupts in user mode
  w_sstatus(x);

  // tell trampoline.S the user page table to switch to.
  uint64_t satp = MAKE_SATP(curr_proc()->pagetable);

  // jump to trampoline.S at the top of memory, which
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64_t fn = TRAPFORWARD + (userret - trapforward);
  // debugcore("return to user, satp=%p, trampoline=%p, kernel_trap=%p\n",satp, fn,  trapframe->kernel_trap);
  ((void (*)(uint64_t, uint64_t))fn)(TRAPFRAME, satp);
}


void kernel_exception_handler(uint64_t scause, uint64_t stval, uint64_t sepc) {
  switch (scause & 0xff) {
  case InstructionMisaligned:
    LOG_ERROR("InstructionMisaligned in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case InstructionAccessFault:
    LOG_ERROR("SupervisorEnvCall in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case IllegalInstruction:
    LOG_ERROR("IllegalInstruction in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case Breakpoint:
    LOG_ERROR("Breakpoint in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case LoadMisaligned:
    LOG_ERROR("LoadMisaligned in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case LoadAccessFault:
    LOG_ERROR("LoadAccessFault in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case StoreMisaligned:
    LOG_ERROR("StoreMisaligned in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case StoreAccessFault:
    LOG_ERROR("StoreAccessFault in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case SupervisorEnvCall:
    LOG_ERROR("SupervisorEnvCall in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case MachineEnvCall:
    LOG_ERROR("MachineEnvCall in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case InstructionPageFault:
    LOG_ERROR("InstructionPageFault in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case LoadPageFault:
    LOG_ERROR("LoadPageFault in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  case StorePageFault:
    LOG_ERROR("StorePageFault in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  default:
    LOG_ERROR("Unknown exception in kernel: %p, stval = %p sepc = %p\n", scause, stval, sepc);
    break;
  }
  PANIC("kernel exception");
}


// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void kerneltrap() {
  uint64_t sepc = r_sepc();
  uint64_t sstatus = r_sstatus();
  uint64_t scause = r_scause();
  uint64_t stval = r_stval();
  // ASSERT(!intr_get(), "Interrupt can not be turned on in trap handler");
  // ASSERT((sstatus & SSTATUS_SPP) != 0, "kerneltrap: not from supervisor mode");
  // LOG_DEBUG("Enter kernel trap handler, scause=%p, sepc=%p", scause,sepc);

  if (scause & (1ULL << 63)) {  // interrupt
    kernel_interrupt_handler(scause, stval, sepc);
    } else {  // exception
    kernel_exception_handler(scause, stval, sepc);
  }

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
  w_sstatus(sstatus);
  // debugcore("About to return from kernel trap handler");

  // go back to kernelvec.S
}