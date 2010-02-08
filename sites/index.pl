#! /usr/bin/perl

use strict;
use CGI qw(param);
#use warnings;

print "content-type: text/html\n\n";
print "<html>\n\n";

print "<a href=\"..\">up</a><br />";
my @files =<*>;
@files = sort(@files);
foreach my $file (@files){
	if ($file !~ /\.pl$/ && $file !~ /^\./ && $file !~ /template/ && $file !~ /^ip$/){	#If file is neither perl nor hidden
	print " <a href=\"?site=".$file."\">$file</a> |";
	}
}
print "<hr/>";



	my $file = param('site');
	open (FILE, "<$file") || die ("Error opening $file");
	my (%services,%servers,%people,$nuances,$header);
	while (<FILE>){
		my $line = $_;
		chomp $line;
		if ($line =~ /:$/){
			$header = $line;
		}else{
				
			if ($header =~ /Servers/){
				my($key,$value)=(split(/\t/, $line))[0,1];
				$servers{$key}=$value;
			}elsif($header =~ /Services/){
				my($key,$value)=(split(/\t/, $line))[0,1];
				if ($value !~ /^$/){$services{$key}=$value;}
			}elsif($header =~ /People/){
				my($key,$value)=(split(/\t/, $line))[0,1];
				$people{$key}=$value;
			}elsif($header =~ /Nuances/){
				$nuances .= "\n".$line;
			}
		}
	}
	close FILE;
	print "<h2>$file</h2>\n";
	print "<h4>Services</h4>\n<table border=\"1\">\n";
	foreach my $key (sort(keys(%services))){
		if ($services{$key} =~ /,/){
			print "<tr><td>$key</td><td>";
			my @hrefs = split(/,/, $services{$key});
			foreach (@hrefs){
				print "<a href=\"\\\\$_\">$_</a> ";
			}
			print "</td></tr>\n";
		}else{
			print "<tr><td>".$key."</td><td><a href=\"\\\\$services{$key}\">$services{$key}</a></td></tr>\n";
		}
	}
	print "</table>\n";

	print "<h4>Servers</h4>\n<table border=\"1\">\n";
	foreach my $key (sort(keys(%servers))){
		print "<tr><td>".$key."</td><td>".$servers{$key}."</td></tr>\n";
	}
	print "</table>\n";
	
	print "<h4>People</h4>\n<table border=\"1\">\n";
	foreach my $key (sort(keys(%people))){
#		print "<tr><td>".$key."</td><td>$people{$key}<td></tr>\n";

		if ($people{$key} =~ /,/){
			my @people=split(/,/, $people{$key});
			print "<tr><td>$key</td><td>";
			foreach (@people){
				print "<a href=\"mailto:$_\">$_</a> ";
			}
			print "</td></tr>\n";
		}else{
			print "<tr><td>$key</td><td><a href=\"mailto:$people{$key}\">$people{$key}</a></td></tr>";
		}
	}
	print "</table>\n";

	print "<h4>Nuances</h4>";
	print "<pre>\n";
	print $nuances;
	print "\n</pre>\n";
	

print "<hr>\n<pre>";
open (IPS, "<./ip");
while(<IPS>){
	print $_;
} 
print "</pre>";

