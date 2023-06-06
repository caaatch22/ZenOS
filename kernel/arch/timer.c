#include "arch/timer.h"
#include "arch/riscv.h"
#include "common/common.h"



uint64_t get_tick() {
  return r_time();
}
