// asm code to manipulate csrs and so on
#ifndef RISCV_H
#define RISCV_H

#include "defs.h"

#define MSTATUS_SIE (1<<1)
#define MSTATUS_MIE (1<<3)
#define MSTATUS_SPIE (1<<5)
#define MSTATUS_SPP (1<<8)
#define MSTATUS_MPP_MASK (3<<11)
#define MSTATUS_MPP_SMODE (1<<11)
#define MSTATUS_MPP_UMODE (0)

static inline uint64 r_misa()
{
  uint64 x;
  asm volatile(
      "csrr %0, misa"
      : "=r"(x));
  return x;
}

static inline uint64 r_mhartid()
{
  uint64 x;
  asm volatile(
      "csrr %0, mhartid"
      : "=r"(x));
  return x;
}

static inline uint64 r_mstatus()
{
  uint64 x;
  asm volatile(
      "csrr %0, mstatus"
      : "=r"(x));
  return x;
}

static inline void w_mstatus(uint64 x)
{
  asm volatile(
      "csrw mstatus, %0"
      :
      : "r"(x));
}

static inline uint64 r_medeleg()
{
  uint64 x;
  asm volatile(
      "csrr %0, medeleg"
      : "=r"(x));
  return x;
}

static inline void w_medeleg(uint64 x)
{
  asm volatile(
      "csrw medeleg, %0"
      :
      : "r"(x));
}

static inline uint64 r_mideleg()
{
  uint64 x;
  asm volatile(
      "csrr %0, mideleg"
      : "=r"(x));
  return x;
}

static inline void w_mideleg(uint64 x)
{
  asm volatile(
      "csrw mideleg, %0"
      :
      : "r"(x));
}

static inline uint64 r_mie()
{
  uint64 x;
  asm volatile(
      "csrr %0, mie"
      : "=r"(x));
  return x;
}

static inline void w_mie(uint64 x)
{
  asm volatile(
      "csrw mie, %0"
      :
      : "r"(x));
}

static inline uint64 r_mtvec()
{
  uint64 x;
  asm volatile(
      "csrr %0, mtvec"
      : "=r"(x));
  return x;
}

static inline void w_mtvec(uint64 x)
{
  asm volatile(
      "csrw mtvec, %0"
      :
      : "r"(x));
}

static inline uint64 r_mepc()
{
  uint64 x;
  asm volatile(
      "csrr %0, mepc"
      : "=r"(x));
  return x;
}

static inline void w_mepc(uint64 x)
{
  asm volatile(
      "csrw mepc, %0"
      :
      : "r"(x));
}

static inline uint64 r_mcause()
{
  uint64 x;
  asm volatile(
      "csrr %0, mcause"
      : "=r"(x));
  return x;
}

static inline void w_mcause(uint64 x)
{
  asm volatile(
      "csrw mcause, %0"
      :
      : "r"(x));
}

static inline uint64 r_pmpcfg0()
{
  uint64 x;
  asm volatile(
      "csrr %0, pmpcfg0"
      : "=r"(x));
  return x;
}

static inline void w_pmpcfg0(uint64 x)
{
  asm volatile(
      "csrw pmpcfg0, %0"
      :
      : "r"(x));
}

//following are s-mode csrs
static inline uint64 r_stvec()
{
  uint64 x;
  asm volatile(
      "csrr %0, stvec"
      : "=r"(x));
  return x;
}

static inline void w_stvec(uint64 x)
{
  asm volatile(
      "csrw stvec, %0"
      :
      : "r"(x));
}

static inline uint64 r_sie()
{
  uint64 x;
  asm volatile(
      "csrr %0, sie"
      : "=r"(x));
  return x;
}

static inline void w_sie(uint64 x)
{
  asm volatile(
      "csrw sie, %0"
      :
      : "r"(x));
}

static inline uint64 r_sip()
{
  uint64 x;
  asm volatile(
      "csrr %0, sip"
      : "=r"(x));
  return x;
}

static inline void w_sip(uint64 x)
{
  asm volatile(
      "csrw sip, %0"
      :
      : "r"(x));
}

static inline uint64 r_sscratch()
{
  uint64 x;
  asm volatile(
      "csrr %0, sscratch"
      : "=r"(x));
  return x;
}

static inline void w_sscratch(uint64 x)
{
  asm volatile(
      "csrw sscratch, %0"
      :
      : "r"(x));
}

static inline uint64 r_sepc()
{
  uint64 x;
  asm volatile(
      "csrr %0, sepc"
      : "=r"(x));
  return x;
}

static inline void w_sepc(uint64 x)
{
  asm volatile(
      "csrw sepc, %0"
      :
      : "r"(x));
}

static inline uint64 r_scause()
{
  uint64 x;
  asm volatile(
      "csrr %0, scause"
      : "=r"(x));
  return x;
}

static inline void w_scause(uint64 x)
{
  asm volatile(
      "csrw scause, %0"
      :
      : "r"(x));
}

static inline uint64 r_satp()
{
  uint64 x;
  asm volatile(
      "csrr %0, satp"
      : "=r"(x));
  return x;
}

static inline void w_satp(uint64 x)
{
  asm volatile(
      "csrw satp, %0"
      :
      : "r"(x));
}
#endif
