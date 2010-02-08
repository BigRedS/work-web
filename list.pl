#! /usr/bin/perl

use strict;
use 5.010;

my @f = ("");

&topBit();


opendir(D, ".");

my @files = readdir(D);


foreach (@f){
	push @files, $_;
}

@files = sort(@files);

say "\t\t\t<center><h1>jup-linux2.sgl.group</h1></center>";


foreach (@files) {
	if (($_ !~ /^\./) && ($_ !~ /\.pl$/)){
		say "\t\t\t<a href='./$_'>$_</a><br />";
	}
}

&bottomBit();

sub topBit() {
print <<EOF
Content-type: text/html


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>jup-linux2</title>
	</head>
	<body>
		<div style='width:70%;margin-right:auto;margin-left:auto;'>

EOF
}

sub bottomBit() {
print <<EOF
  <p>
    <a href="http://validator.w3.org/check?uri=referer"><img
        src="http://www.w3.org/Icons/valid-xhtml10-blue"
	style="border:0;"
        alt="Valid XHTML 1.0 Transitional" height="31" width="88" /></a>
  </p>
  
		</div>
	</body>
</html>
EOF
}
