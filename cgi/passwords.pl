#! /usr/bin/perl

use strict;
use warnings;

## Let the browser know what we're sending it
print "content-type: text/html\n\n";

## Spew some HTML since we're not going to get away with plain text formatting
print "<html>\n\t<head>";
print "\t\t<title>Passwords!</title>";
print "\t</head>";
print "<body>\n\t<h1>Avi's Magical Password Generator</h1>";

## Define two sets of data. The first is the lengths of password we want to produce, the second is the allowed characters. Each space-separated
my $lengths="1 4 8 10 20 30 50 80 100";
my $characters="A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h 
i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0 ! $ % ^ & _ + = : ; @ # ~ , 
. ? ";

## Split the above by space into arrays
my @chars=split(/ /, $characters);
my @lens=split(/ /, $lengths);

## Work out how many characters we are allowed, so that when we come to pick one at random we can use this number as the maximum.
my $chars_count = @chars;
## Spew out some html for pretty formatting:
print "<table>\n";
print "\t<tr><td>length</td><td></td></tr>";


## The loop!
foreach (@lens){
	my $length=$_;
	my $count;
	## The first cell of the row, containing the length:
	print "\n\t<tr><td>".$_."</td><td>";
	for ($count = 1; $count <= $length; $count++){
		## Working backwards, $chars_count is the above-defined number of characters we have to play with, rand($chars_count) picks
		## a random number between 0 and $chars_count, and int(rand($chars_count)) makes sure it's an integer. This in the square 
		## brackets after $chars means we're picking a random element out of the array @chars, which is effectively
		## picking a random character out of the list of allowed ones.
		print $chars[int(rand($chars_count))];
	}
	print "</td></tr>\t\t\n";
}
print "</table>\n\n";


print "<a href=./src/password.txt>sauce</a> <a href=..>home</a>";
print "</body>";

