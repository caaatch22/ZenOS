#include "arch/cpu.h"
#include "arch/riscv.h"
#include "common/common.h"

struct cpu cpus[NCPU];
// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *
mycpu(void) {
  //ASSERT(!intr_get(), "mycpu");
  int id = cpuid();
  struct cpu *c = &cpus[id];
  return c;
}

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int cpuid() {
  return r_tp();
}

// Barrier
// Will not return until all cores halted
void wait_all_halt() {
  for (int i = 0; i < NCPU; i++) {
    while (!halted[i])
      ;
  }
}

volatile int booted[NCPU];  // whether a core is booted
volatile int halted[NCPU];  // whether a core is halted

/**
 * set halted of this core to True
 */
void halt() {
  uint64_t hartid = r_tp();
  halted[hartid] = 1;
}

void init_cpu() {
  for (int i = 0; i < NCPU; i++) {
    cpus[i].proc = NULL;
    cpus[i].intr_disable_depth = 0;
    cpus[i].prev_intr_status = 0;
  }
}

/**
 * @brief For debugging.
 * @param c cpu
 */
void print_cpu(struct cpu *c) {
  LOG_DEBUG("* ---------- CPU INFO ----------\n");
  // LOG_DEBUG("* core id: %d\n", c->core_id);
  LOG_DEBUG("* prev interrupt: %d\n", c->prev_intr_status);
  LOG_DEBUG("* intr disable depth: %d\n", c->intr_disable_depth);
  LOG_DEBUG("* proc: %p\n", c->proc);
  LOG_DEBUG("* -------------------------------\n\n");
}
