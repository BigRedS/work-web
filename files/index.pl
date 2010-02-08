#! /usr/bin/perl

use strict;
use warnings;
use CGI qw(param);
use Tie::IxHash;

print "Content-type: text/html\n\n";

## Create hash of toplinks, then display them at the top.
tie my %options, 'Tie::IxHash';
tie my %other_links, 'Tie::IxHash';
tie my %graphs, 'Tie::IxHash';
%options = (
	'U: Drive Files' => 'users',
	'U: Drive Sizes' => 'usum',
	'shares' => 'sum',
	'PST files' => 'pst'
);
%other_links =(
	'Brief Explanation' => 'briefexplanation',
	'File List' => 'files',
	'filefinder.pl' => 'filefinder',
	'files.pl' => 'files.txt'
);

print "Formatted output: ";
while (my($name,$href)=each(%options)){print "<a href=\"?show=".$href."\">$name</a> | ";}
print "<a href=\"http://localhost/monitor/sgl.group/jup-linux2.sgl.group.html\">Graphs</a>";
print "<br />Textual trivia: ";
while (my($name,$href)=each(%other_links)){ print "<a href=\"".$href."\">$name</a> | ";}
print "<hr>";

## Build command and execute it, then print the results:
#y $show="usum";
my $show;
#unless(defined($show=param('show')){$show="usam"};

if(defined(param('show'))){$show=param('show');}else{$show='usum';}


my $cmd="/home/avi/bin/live/files/files.pl ".$show." html";
my @output = qx($cmd);
foreach (@output){
	print;
}


## show the extensions we're looking for:

unless($show == "shares"){
	print "Extensions:<br />";
	open (EXTENSIONS_LIST, "</srv/http/files/extensions") || die ("Error opening extensions list at /srv/http/files/extensions/");
		while (<EXTENSIONS_LIST>){print ;}
	close EXTENSIONS_LIST;
}

