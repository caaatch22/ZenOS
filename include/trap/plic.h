#ifndef PLIC_H
#define PLIC_H
//
// the riscv Platform Level Interrupt Controller (PLIC).
//
void plicinit(void);
void plicinithart(void);
// ask the PLIC what interrupt we should serve.
int plic_claim(void);

// tell the PLIC we've served this IRQ.
void plic_complete(int irq);

#endif  // PLIC_H