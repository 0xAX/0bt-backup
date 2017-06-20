/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 * 0bt-install - a util to install 0bt bootloader on the
 * given storage.
 */

#include <iostream>

using namespace std;

static const char *default_disk_image = "disk.img";

[[noreturn]]
static void usage() {
	cout << "0bt-install Ver - " << VERSION << endl;
	cout << "Usage: 0bt-install [diskname]" << endl;
	exit(0);
}

int main(int argc, char *argv[]) {

	if (argc == 1)
		usage();
	return 0;
}
