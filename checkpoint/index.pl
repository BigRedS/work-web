#! /usr/bin/perl

use strict;
use warnings;

print "Content-type: text/plain\n\n";

my (@logs, @list, %seen);

@logs = </mnt/wandsworth/checkpoint/*>;
foreach (@logs){
	push (@list, lc((split(/\./,(split(/\//, $_))[4]))[0]));
}

@list = sort(@list);
my @uniqed = grep !$seen{$_}++, @list;

foreach (@uniqed){
	print;
	print "\n";
}
