#!/usr/bin/perl

open FILE, "command_list.txt" or die $!;

while (<FILE>) {
    system("$_");
    sleep 0.1;
}

close FILE or die $!;

