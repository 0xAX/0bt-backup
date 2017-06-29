#include "stage1.hpp"

void bios_print_string(const char *str) {
	while(*str)
		print_char(*str++);
}
