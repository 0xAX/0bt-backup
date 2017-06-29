#include "stage1.hpp"

const char* greetings = "Hello from 0bt!";

extern "C" {
	void stage1_main() {
		clear_screen();
		bios_print_string(greetings);
	}
}
