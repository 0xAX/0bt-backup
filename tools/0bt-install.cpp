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

static const char *default_disk_namge = "disk.img";

static void usage() {
	cout << "";	
}

int main(int argc, char *argv[]) {

	if (argc == 1)
		usage();
	return 0;
}