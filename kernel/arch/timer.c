#include "arch/timer.h"
#include "arch/riscv.h"
#include "common/common.h"
#include "proc/proc.h"

struct timer timer_pool[NTIMER];
struct spinlock timers_lock;

void timerinit() {
  init_spinlock(&timers_lock, "timer");
  for (int i = 0; i < NTIMER; i++) {
    timer_pool[i].wakeup_tick = 0;
    timer_pool[i].valid = 0;
    init_spinlock(&timer_pool[i].guard_lock, "");
  }
}

struct timer *add_timer(uint64_t expires_us) {
  struct timer *timer = NULL;
  acquire_spinlock(&timers_lock);
  for (int i = 0; i < NTIMER; i++) {
    acquire_spinlock(&timer_pool[i].guard_lock);
    if (!timer_pool[i].valid) {
      timer = &timer_pool[i];
      timer->wakeup_tick = get_tick() + US_TO_TICK(expires_us);
      timer->valid = TRUE;
      // don't release_spinlock the guard lock here
      break;
    }
    release_spinlock(&timer_pool[i].guard_lock);
  }
  release_spinlock(&timers_lock);
  return timer;
}

int del_timer(struct timer *timer) {
  acquire_spinlock(&timer->guard_lock);
  if (!timer->valid) {
    LOG_INFO("del_timer: timer %p is not valid\n", timer);
    release_spinlock(&timer->guard_lock);
    return -1;
  }
  timer->valid = FALSE;
  release_spinlock(&timer->guard_lock);
  return 0;
}

void try_wakeup_timer() {
  uint64_t tick = get_tick();
  acquire_spinlock(&timers_lock);
  for (int i = 0; i < NTIMER; i++) {
    acquire_spinlock(&timer_pool[i].guard_lock);
    if (timer_pool[i].valid && tick >= timer_pool[i].wakeup_tick) {
      wakeup(&timer_pool[i]);
    }
    release_spinlock(&timer_pool[i].guard_lock);
  }
  release_spinlock(&timers_lock);
}

uint64_t get_min_wakeup_tick() {
  uint64_t min_tick = ~0ULL;
  acquire_spinlock(&timers_lock);
  for (int i = 0; i < NTIMER; i++) {
    acquire_spinlock(&timer_pool[i].guard_lock);
    if (timer_pool[i].valid && timer_pool[i].wakeup_tick < min_tick) {
      min_tick = timer_pool[i].wakeup_tick;
    }
    release_spinlock(&timer_pool[i].guard_lock);
  }
  release_spinlock(&timers_lock);
  return min_tick;
}

void start_timer_interrupt(){
  w_sie(r_sie() | SIE_STIE);
  set_next_timer();
}

void stop_timer_interrupt(){
  w_sie(r_sie() & ~SIE_STIE);
}

/// Set the next timer interrupt (10 ms)
void set_next_timer() {
  // 100Hz @ QEMU
  const uint64_t timebase = TICK_FREQ / TIME_SLICE_PER_SEC; // how many ticks
  uint64_t slice_tick = r_time() + timebase;
  uint64_t timer_tick = get_min_wakeup_tick();
  set_timer(slice_tick < timer_tick ? slice_tick : timer_tick);
}


uint64_t get_time_ms() {
  uint64_t time = r_time();
  return time / (TICK_FREQ / MSEC_PER_SEC);
}

uint64_t get_time_us() {
  return r_time() / (TICK_FREQ / USEC_PER_SEC);
}

uint64_t get_tick() {
  return r_time();
}