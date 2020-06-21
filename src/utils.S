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

.globl mutex_lock
mutex_lock:

	ldr  x7, =PBASE  
	ldr  x6, =0x00215040
	ldr  x5, =0x00215054
	add  x6, x6, x7
	add  x5, x5, x7
	ldr  w4, [x5]
	ldr  w5, =0x20
	and  w4, w4, w5
	cbz  w4, mutex_lock
	ldr w7, =48
	str  w7, [x6] 

	ldxr x1, [x0]
	cbnz x1, mutex_lock
	ldr x1, =1	

	ldr  x7, =PBASE  
	ldr  x6, =0x00215040
	add  x6, x6, x7
	ldr x7, =49
	str  x7, [x6] 
	dmb sy

enable_lock:	
	stxr w2, x1, [x0]
	cbnz w2, enable_lock

	ldr  x7, =PBASE  
	ldr  x6, =0x00215040
	add  x6, x6, x7
	ldr x7, =9
	str  x7, [x6] 
	ret

.globl mutex_unlock
mutex_unlock:
	dmb sy
	ldr x1, =0
	stxr w2, x1, [x0]
	cbnz w2, mutex_unlock
	ret
