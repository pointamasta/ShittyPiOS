#include "mini_uart.h"
#include "utils.h"
void kernel_main(void)
{
	uart_init();
	uart_send_string("Hello, world!\r\n");
	uart_send_string("First CPU\r\n");
}

void other_core_main(int CPUID){
/*	if (CPUID == 1)
		uart_send_string("Second CPU\r\n");
	if (CPUID == 2)
		uart_send_string("Third CPU\r\n");
	if (CPUID == 3)
		uart_send_string("Fourth CPU\r\n");
*/
	while(1);
}
