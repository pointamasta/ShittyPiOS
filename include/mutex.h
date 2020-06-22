#ifndef _MUTEX_H
#define _MUTEX_H

#include "utils.h"

extern void mutex_lock(unsigned int *mutex);
extern void mutex_unlock(unsigned int *mutex);

#endif /*_MUTEX_H*/
