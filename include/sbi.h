#ifndef SBI_H
#define SBI_H

#include "defs.h"
#include "log.h"

//legacy functions
#define SBI_LEGACY_SET_TIMER_EID 0
#define SBI_LEGACY_CONSOLE_PUTCHAR_EID 1
#define SBI_LEGACY_CONSOLE_GETCHAR_EID 2
#define SBI_LEGACY_CLEAR_IPI_EID 3
#define SBI_LEGACY_SEND_IPI_EID 4
#define SBI_LEGACY_REMOTE_FENCE_I_EID 5
#define SBI_LEGACY_REMOTE_SFENCE_VMA_EID 6
#define SBI_LEGACY_REMOTE_SFENCE_VMA_ASID_EID 7
#define SBI_LEGACY_SHUTDOWN_EID 8
//end

#define SBI_TIME_EID 0x54494D45
#define SBI_SET_TIMER_FID 0

#define SBI_IPI_EID 0x735049
#define SBI_SEND_IPI_FID 0

#define SBI_HSM_EID 0x48534
#define SBI_HART_START_FID 0
#define SBI_HART_STOP_FID 1
#define SBI_HART_GET_STATUS_FID 2
#define SBI_HART_SUSPEND_FID 3

#define SBI_SRST_EID 0x53525354
#define SBI_SYSTEM_RESET_FID 0
#define SBI_RESET_TYPE_SHUTDOWN 0x0
#define SBI_RESET_TYPE_COLD_REBOOT 0x1
#define SBI_RESET_TYPE_WARM_REBOOT 0x2
#define SBI_RESET_REASON_NONE 0x0
#define SBI_RESET_REASON_SYSTEM_FAILURE 0x1

void console_putchar(int);

int console_getchar(void);

void shutdown(void);

void set_timer(uint64);

#endif
