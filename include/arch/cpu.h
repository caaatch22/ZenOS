#if !defined(CPU_H)
#define CPU_H

#include "common/defs.h"

#ifndef NCPU
#define NCPU (1)  // TODO: support multicore
#endif // NCPU

extern volatile int booted[NCPU];
extern volatile int halted[NCPU];

// Saved registers for kernel context switches.
struct context {
  uint64_t ra;
  uint64_t sp;

  // callee-saved
  uint64_t s0;
  uint64_t s1;
  uint64_t s2;
  uint64_t s3;
  uint64_t s4;
  uint64_t s5;
  uint64_t s6;
  uint64_t s7;
  uint64_t s8;
  uint64_t s9;
  uint64_t s10;
  uint64_t s11;
};

// Per-CPU state.
struct cpu {
  struct proc *proc;      // The process running on this cpu, or null.
  struct context prev_context; // swtch() here to enter scheduler().
  uint32_t intr_disable_depth;   // Depth of push_off() nesting.
  uint64_t prev_intr_status;  // Were interrupts enabled before push_off()?      
};

// debug print
void print_cpu(struct cpu *c);
extern struct cpu cpus[NCPU];

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *mycpu(void);

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int cpuid();

void halt();

void wait_all_halt();

void init_cpu();

#endif // CPU_H
