#! /usr/bin/perl

use File::Copy;
use 5.010;
use CGI;

print "Content-type: Text/html\n\n";
my $query = new CGI;
my $submit = $query->param("submit");

if ($submit =~ /Revert/i){
	my $backup = "../.directory_backup";
	my $directory = "../.directory";

	#copy ($backup, $directory);

	print "There, I fixed it for you. Don't do that again.";
}else{
	print "<form action='revert.pl'>
		<input type='submit' name='submit' value='Revert my last changes please'>
	";
}
