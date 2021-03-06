#include "mm.h"

.section ".text.boot"

.globl _start
_start:
	mrs	x0, mpidr_el1		
	and	x0, x0,#0xFF		// Check processor id
	cbz	x0, master		// Hang for all non-primary CPU
	bl	proc_hang

proc_hang: 
	b 	proc_hang

master:
	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0
	bl 	memzero

	mov	sp, #LOW_MEMORY 
	bl	kernel_main
	b 	proc_hang		// should never come here

slaves:
	mov	x1, #LOW_MEMORY
	mov	x2, x0
	add	x2, x2, #2
	mul	x1, x1, x2
	mov	sp, x1 
	b	other_core_main
	b 	proc_hang		// should never come here
