#!/usr/bin/perl

use strict;
use warnings;
use Run::PidFile;

my $pidh = Run::PidFile->new('test.pid', Nonblock => 1) or die "Cant create Run::PidFile object: $!\n\n";
print "Begin\n";
$pidh->open or die "Cant create and lock pid file: $!\n\n";
print "Running...\n";
while( 1 ) {
    sleep(1);
}
