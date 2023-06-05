#include "trap/plic.h"
#include "arch/hw.h"
#include "arch/cpu.h"
#include "arch/riscv.h"
#include "common/defs.h"
//
// the riscv Platform Level Interrupt Controller (PLIC).
//
void plicinit(void)
{
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32_t *)(VIRT_MMIO_PLIC_BASE + VIRTIO0_IRQ * 4) = 1;
}

void plicinithart(void)
{
  int hart = cpuid();
  // set uart's enable bit for this hart's S-mode.
  *(uint32_t *)PLIC_SENABLE(hart) = (1 << VIRTIO0_IRQ);
  // set this hart's S-mode priority threshold to 0.
  *(uint32_t *)PLIC_SPRIORITY(hart) = 0;
}

// ask the PLIC what interrupt we should serve.
int plic_claim(void)
{
  int hart = cpuid();
  int irq = *(uint32_t *)PLIC_SCLAIM(hart);
  return irq;
}

// tell the PLIC we've served this IRQ.
void plic_complete(int irq)
{
  int hart = cpuid();
  *(uint32_t *)PLIC_SCLAIM(hart) = irq;
}
