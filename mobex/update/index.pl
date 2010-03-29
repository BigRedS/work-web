#! /usr/bin/perl

use strict;
use 5.010;

use CGI;
use CGI::Carp qw (fatalsToBrowser);
use File::Basename;
use File::Copy;
use Text::CSV;

my $directory = "../.directory";
my $directory_backup = "../.directory_backup";

say "content-type: text/html\n\n";
print "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'DTD/xhtml1-strict.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
 <head>
   <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
   <title>Directory Update<title>
 </head>
 <body>
";
my $query = new CGI;  



my $filename = $query->param("file");  

if ($filename){
	my $fh = $query->upload("file");
	my $csv = Text::CSV->new();

	say "<table><tr><td>Name</td><td>Number</td>";

	copy($directory, $directory_backup);

	open (DIR, ">$directory");

	while (<$fh>){
		next if ($. == 1);
		if ($csv->parse($_)) {
	        	my @columns = $csv->fields();
	 		say "<tr><td>$columns[2]</td><td>$columns[1]</tr>";
			say DIR $columns[2]."£".$columns[1];
		}else{
			my $err = $csv->error_input;
			say "<tr><td>ERROR</td><td>Failed to parse line: $err</td></tr>";
		}
	
	}
	say "<table>";


	say "If this is wrong, clicking <a href='revert.pl'>here</a> will revert changes immediately.";

	
}else{
	print "
	   <form action='index.pl' method='post' enctype='multipart/form-data'>
	     <input type='hidden' name='do' type='submit'>
	     <p>Directory File: <input type='file' name='file' /></p>
	     <p><input type='submit' name='Submit' value='Do It.' /></p>
	   </form>
	";
}


print "
	 </body>
	</html>
";


