#include "peripherals/mini_uart.h"

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
	cmp  w4, #0 
	beq mutex_lock
	ldr w7, =48
	str  w7, [x6] 

	ldxr x1, [x0]
	cmp x1, #0 
	bne mutex_lock
	ldr x1, =1
	b lock_checked	

lock_checked:
	ldr  x7, =PBASE  
	ldr  x6, =0x00215040
	ldr  x5, =0x00215054
	add  x6, x6, x7
	add  x5, x5, x7
	ldr  w4, [x5]
	ldr  w5, =0x20
	and  w4, w4, w5
	cmp  w4, #0 
	bne lock_checked
	ldr w7, =49
	str  w7, [x6] 
	
	dmb sy
	b enable_lock

enable_lock:	
	stxr w2, x1, [x0]
	cmp w2, #0 
	bne enable_lock
	
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
