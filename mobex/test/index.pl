#! /usr/bin/perl

use strict;
use CGI qw(header param);

print header;


my $q = param('query');
my $f = "./.directory";	# Path to the file to run lookups against. It's
			# a list of names and mobex numbers, £-separated:
			# 	Firstname Surname £ Mobex

open(F, "<$f") or die "Error opening address file $f";

&startPage();
if ($q =~ /\w/){
	my %matches;
	my $count = 0;
	while(<F>){
		my ($na,$no) = (split(/£/))[0,1];
		$no =~ s/\s//;	# Strip whitespace from number
		if ($no =~ /\d{4}/){	# If the mobex isn't 4 digits long it's
					# probably not a mobex number so we're 
					# going to ignore the whole line.
			if(($q =~ /^ALL$/) or ($na =~ /$q/i)){	
				# Name:
				chomp $na;		 # Strip trailing linebreaks
				$na =~ s/\s+$//;	 # Strip trailing whitespace
				$na = uc($na);		 # All upper-case
				$na =~ s/(\w+)/\u\L$1/g; # All lower-case except
							 # 1st letter of each word
				$na =~ s/pda//i; 	 # strip 'pda'
				$na =~ s/Bb//i;  	 # strib 'Bb' (Blackberry)
				# Number:
				chomp $no;
				# Write matches to a hash:
				$matches{$na}=$no;
				$count++;
			}
		}
	}
	close F;

	if($count > 0){
		&startTable;
		&midTable(\%matches);
		&endTable;
	}else{
		print "<p><strong>No matches found</strong></p>";
	}
}else{
	if(defined $q){
		print "<p><strong>Error:</strong> No search term entered";
	}
}
&endPage;

# This sub prints the top of the HTML document for us. Everything we *always* want
# at the top of the page. 
sub startPage(){
	print <<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

	<head>
		<link rel='stylesheet' href='./styles.css' type='text/css' />
		<title>St Ives Inet Directory</title>
	</head>
	<body>
		<div class='content'>
			<h1>St Ives Inet Directory</h1>
			<p>Enter a name or part of a name to look up an Inet number. Search for 'ALL' (in caps) to get a full list of all Mobex numbers.</p>
			<form method='post' action='.'>
				<div>
					<input type='text' name='query' value='$q' />
					<input type='submit' name='search' value='Search' />
				</div>
			</form>
EOF
}

# This sub prints the beginning of the table. It's the chunk of HTML that we want
# between the consistent content defined above and the results, but we only want it 
# when we have results.
sub startTable(){
	print <<EOF	
			<br /><br />
			<table>
				<tr>
					<th>Name</th><th>From Deskphone</th><th>From Mobile</th>
				</tr>
EOF
}

# This sub prints the middle of the table. It iterates through the hash of results
# and prints them out in a table. It just prints a table row at a time.
sub midTable() {
	my $matches = $_[0]; # $_[0] (and so $matches) is a reference to the hash
			     # of results we created earlier.
	for my $k (sort keys %$matches){
		print <<EOF
				<tr>
					<td>$k</td><td>71$$matches{$k}</td><td>$$matches{$k}</td>
				</tr>
EOF
	}
}

# This sub closes the table. It's the chunk of HTML that we want between the dynamic 
# results above and the consistent stuff we always have. It closes whatever elements
# we've put the results into above. Currently, just a table.
sub endTable(){
	print <<EOF
			</table>

EOF
}

# This sub ends the page. It closes anything we opened to stick the whole results in, 
# and is always invoked. It should end with a </html> and probably include a </body>
sub endPage(){
	print <<EOF
		
		<br /><p>If you have any problems, please contact <a href='mailto:techadmin\@st-ives.co.uk?subject=Inet directory'>Technical Services</a>.</p>
		</div><!--content-->
	</body>
</html>
EOF
}

sub log() {
	my $query=$_[1];
	my $s = time . " " . $ENV{'REMOTE_ADDR'}. "\"$q\"\n";
	open(L, ">>./.log") || die ("error opening logfile");
	print L $s;
	close L;
}
