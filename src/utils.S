#include "peripherals/mini_uart.h"

.globl put32
put32:
	str w1,[x0]
	ret

.globl get32
get32:
	ldr w0,[x0]
	ret

.globl safe_get32
safe_get32:
	ldxr w0,[x0]
	ret

.globl delay
delay:
	subs x0, x0, #1
	bne delay
	ret

.globl safe_put32
safe_put32:
	stxr w2, w1, [x0]
	cbnz w2, safe_put32
	ret

