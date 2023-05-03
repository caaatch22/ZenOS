#include "status.h"

extern cpu_status CPU_STATUS[];

cpu_status *mycpu(){
  uint64 hartid;
  asm volatile(
      "add %0,tp,x0"
      : "=r"(hartid)
      :);
  return &(CPU_STATUS[hartid]);
}
