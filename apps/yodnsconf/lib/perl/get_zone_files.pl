#!/usr/bin/perl

open FILE, "get_docs.txt" or die $!;

while (<FILE>) {
    system("$_");
    sleep 0.1;
}

close FILE or die $!;

