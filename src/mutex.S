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
	ldr w7, [x0]
	str  w7, [x6] 
	ldaxr w1, [x0]
	cmp w1, #0 
	bne mutex_lock	
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
	beq lock_checked
	ldr w7, =49
	str  w7, [x6] 
enable_lock:	
	ldr w1, ='l'
	dmb sy
	stxr w2, w1, [x0]
	cmp w2, #0 
	bne enable_lock
	dmb sy
	ret

.globl mutex_unlock
mutex_unlock:
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
	ldr w7, [x0]
	str  w7, [x6] 
	
	dmb sy
	ldr w1, =0
	stxr w2, w1, [x0]
	dmb sy
	cmp w2, #0 
	bne mutex_unlock
	
	ret
