#ifndef	_BOOT_H
#define	_BOOT_H

extern void delay ( unsigned long);
extern void put32 ( unsigned long, unsigned int );
extern void safe_put32 ( unsigned long, unsigned int );
extern unsigned int get32 ( unsigned long );
extern unsigned int safe_get32 ( unsigned long );


extern void mutex_lock(unsigned long *mutex);
extern void mutex_unlock(unsigned long *mutex);
#endif  /*_BOOT_H */
