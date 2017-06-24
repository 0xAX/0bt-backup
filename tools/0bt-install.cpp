/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 * 0bt-install - a util to install 0bt bootloader on the
 * given storage.
 */

#include <fstream>
#include <iostream>

using namespace std;

#define MBR_SIZE 446

static const string default_disk_image = "disk.img";
static const string default_mbr_path = "/boot/0bt/boot0_x86_64.bin";

[[noreturn]] static void usage()
{
	cout << "0bt-install Ver - " << VERSION << endl;
	cout << "Usage: 0bt-install [diskname] [path to mbr]" << endl;
	cout << endl;
	cout << "  -h/--help - print this message" << endl;
	exit(0);
}

static void write_bootloader(const string *disk, const string *mbr)
{
	fstream disk_fstream;
	fstream mbr_fstream;

	disk_fstream.open(*disk, fstream::in | fstream::binary);

	if (!disk_fstream)
	{
		perror("error while opening a device");
		exit(1);
	}

	mbr_fstream.open(*mbr, fstream::in | fstream::binary);

	if (!mbr)
	{
		perror("error while opening a MBR file");
		disk_fstream.close();
		exit(1);
	}

	/*
	 * TODO write mbr here
	 */

	mbr_fstream.close();
	disk_fstream.close();
}

int main(int argc, char *argv[])
{
	const string *disk = nullptr;
	const string *mbr = &default_mbr_path;

	if (argc == 2 && ((string(argv[1]).compare("-h") == 0) ||
			  (string(argv[1]).compare("--help") == 0)))
		usage();

	if (argc == 2)
		disk = new string(argv[1]);
	else
		disk = new string(default_disk_image);

	write_bootloader(disk, mbr);

	delete disk;

	return 0;
}
