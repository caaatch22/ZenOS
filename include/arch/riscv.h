// asm code to manipulate csrs and so on
#ifndef RISCV_H
#define RISCV_H

#include "common/common.h"

#define MSTATUS_SIE (1 << 1)
#define MSTATUS_MIE (1 << 3)
#define MSTATUS_SPIE (1 << 5)
#define MSTATUS_SPP (1 << 8)
#define MSTATUS_MPP_MASK (3 << 11)
#define MSTATUS_MPP_SMODE (1 << 11)
#define MSTATUS_MPP_UMODE (0)

#define SATP_SV39 (8L << 60)
#define MAKE_SATP(pagetable) (SATP_SV39 | (((uint64_t)pagetable) >> 12))

static inline uint64_t r_misa()
{
  uint64_t x;
  asm volatile(
      "csrr %0, misa"
      : "=r"(x));
  return x;
}

static inline uint64_t r_mhartid()
{
  uint64_t x;
  asm volatile(
      "csrr %0, mhartid"
      : "=r"(x));
  return x;
}

static inline uint64_t r_mstatus()
{
  uint64_t x;
  asm volatile(
      "csrr %0, mstatus"
      : "=r"(x));
  return x;
}

static inline void w_mstatus(uint64_t x)
{
  asm volatile(
      "csrw mstatus, %0"
      :
      : "r"(x));
}

static inline uint64_t r_medeleg()
{
  uint64_t x;
  asm volatile(
      "csrr %0, medeleg"
      : "=r"(x));
  return x;
}

static inline void w_medeleg(uint64_t x)
{
  asm volatile(
      "csrw medeleg, %0"
      :
      : "r"(x));
}

static inline uint64_t r_mideleg()
{
  uint64_t x;
  asm volatile(
      "csrr %0, mideleg"
      : "=r"(x));
  return x;
}

static inline void w_mideleg(uint64_t x)
{
  asm volatile(
      "csrw mideleg, %0"
      :
      : "r"(x));
}

static inline uint64_t r_mie()
{
  uint64_t x;
  asm volatile(
      "csrr %0, mie"
      : "=r"(x));
  return x;
}

static inline void w_mie(uint64_t x)
{
  asm volatile(
      "csrw mie, %0"
      :
      : "r"(x));
}

static inline uint64_t r_mtvec()
{
  uint64_t x;
  asm volatile(
      "csrr %0, mtvec"
      : "=r"(x));
  return x;
}

static inline void w_mtvec(uint64_t x)
{
  asm volatile(
      "csrw mtvec, %0"
      :
      : "r"(x));
}

static inline uint64_t r_mepc()
{
  uint64_t x;
  asm volatile(
      "csrr %0, mepc"
      : "=r"(x));
  return x;
}

static inline void w_mepc(uint64_t x)
{
  asm volatile(
      "csrw mepc, %0"
      :
      : "r"(x));
}

static inline uint64_t r_mcause()
{
  uint64_t x;
  asm volatile(
      "csrr %0, mcause"
      : "=r"(x));
  return x;
}

static inline void w_mcause(uint64_t x)
{
  asm volatile(
      "csrw mcause, %0"
      :
      : "r"(x));
}

static inline uint64_t r_pmpcfg0()
{
  uint64_t x;
  asm volatile(
      "csrr %0, pmpcfg0"
      : "=r"(x));
  return x;
}

static inline void w_pmpcfg0(uint64_t x)
{
  asm volatile(
      "csrw pmpcfg0, %0"
      :
      : "r"(x));
}

// following are s-mode csrs

// Supervisor Status Register, sstatus

#define SSTATUS_UIE (1 << 0) // User Interrupt Enable
#define SSTATUS_SIE (1 << 1) // Supervisor Interrupt Enable
#define SSTATUS_UPIE (1 << 4) // User Previous Interrupt Enable
#define SSTATUS_SPIE (1 << 5) // Supervisor Previous Interrupt Enable
#define SSTATUS_SPP (1 << 8) // Previous mode, 1=Supervisor, 0=User

static inline uint64_t r_stvec()
{
  uint64_t x;
  asm volatile(
      "csrr %0, stvec"
      : "=r"(x));
  return x;
}

static inline void w_stvec(uint64_t x)
{
  asm volatile(
      "csrw stvec, %0"
      :
      : "r"(x));
}

// Supervisor Interrupt Enable
#define SIE_SEIE (1L << 9)  // external
#define SIE_STIE (1L << 5)  // timer
#define SIE_SSIE (1L << 1)  // software

static inline uint64_t r_sie()
{
  uint64_t x;
  asm volatile(
      "csrr %0, sie"
      : "=r"(x));
  return x;
}

static inline void w_sie(uint64_t x)
{
  asm volatile(
      "csrw sie, %0"
      :
      : "r"(x));
}

static inline uint64_t r_sip()
{
  uint64_t x;
  asm volatile(
      "csrr %0, sip"
      : "=r"(x));
  return x;
}

static inline void w_sip(uint64_t x)
{
  asm volatile(
      "csrw sip, %0"
      :
      : "r"(x));
}

static inline uint64_t r_sscratch()
{
  uint64_t x;
  asm volatile(
      "csrr %0, sscratch"
      : "=r"(x));
  return x;
}

static inline void w_sscratch(uint64_t x)
{
  asm volatile(
      "csrw sscratch, %0"
      :
      : "r"(x));
}

static inline uint64_t r_sepc()
{
  uint64_t x;
  asm volatile(
      "csrr %0, sepc"
      : "=r"(x));
  return x;
}

static inline void w_sepc(uint64_t x)
{
  asm volatile(
      "csrw sepc, %0"
      :
      : "r"(x));
}

static inline uint64_t r_scause()
{
  uint64_t x;
  asm volatile(
      "csrr %0, scause"
      : "=r"(x));
  return x;
}

static inline void w_scause(uint64_t x)
{
  asm volatile(
      "csrw scause, %0"
      :
      : "r"(x));
}

// Supervisor Trap Value
static inline uint64_t r_stval() {
  uint64_t x;
  asm volatile("csrr %0, stval"
               : "=r"(x));
  return x;
}

static inline uint64_t r_satp()
{
  uint64_t x;
  asm volatile(
      "csrr %0, satp"
      : "=r"(x));
  return x;
}

static inline void w_satp(uint64_t x)
{
  asm volatile(
      "csrw satp, %0"
      :
      : "r"(x));
}

static inline uint64_t r_sstatus()
{
  uint64_t x;
  asm volatile(
      "csrr %0, sstatus"
      : "=r"(x));
  return x;
}

static inline void w_sstatus(uint64_t x)
{
  asm volatile(
      "csrw sstatus, %0"
      :
      : "r"(x));
}

// enable device interrupts
static inline void intr_enable() { w_sstatus(r_sstatus() | SSTATUS_SIE); }

// disable device interrupts
static inline void intr_disable() { w_sstatus(r_sstatus() & ~SSTATUS_SIE); }


static inline uint64_t r_sp() {
  uint64_t x;
  asm volatile("mv %0, sp"
               : "=r"(x));
  return x;
}

// read and write tp, the thread pointer, which holds
// this core's hartid (core number), the index into cpus[].
static inline uint64_t r_tp()
{
  uint64_t x;
  asm volatile("mv %0, tp"
               : "=r"(x));
  return x;
}

static inline void w_tp(uint64_t x)
{
  asm volatile("mv tp, %0"
               :
               : "r"(x));
}

static inline uint64_t r_ra() {
  uint64_t x;
  asm volatile("mv %0, ra"
               : "=r"(x));
  return x;
}

static inline void sfence_vma(void)
{
  asm(
    "sfence.vma zero, zero" //flush TLB
    :
    :);
}

#endif
