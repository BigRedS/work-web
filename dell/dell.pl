#! /usr/bin/perl

use strict;
use warnings;
use CGI qw(param);
use LWP::Simple;
use HTML::TableExtract;
print "Content-type: text/html\n\n";

print "
	<html>
	<h1>Avi's Dell Warranty Status getter</h1>
Stick a service tag in the box, hit the button, see what warranty you have.<br />
	<form action='dell.pl' method='GET'>
		Service Tag: <input type='text' name='tag'><br>
		<input type='submit' label='submit' value='Get it!'>
	</form>
";
if(defined(param('tag'))){
	my $service_tag = param('tag');
	my $url_base = "http://support.euro.dell.com/support/topics/topic.aspx/emea/shared/support/my_systems_info/en/details";
	my $url_params = "?c=uk&cs=ukbsdt1&l=en&s=gen";
	my $url = $url_base.$url_params."&servicetag=".$service_tag;
	my $content = get($url);
	
	# Tell HTML::TableExtract to pick out the table(s) whose class is 'contract_table':
	my $table = HTML::TableExtract->new( attribs => { class => "contract_table" } );
	$table->parse($content);
	
	## Gimme infos!
	foreach my $ts ($table->tables) {
		print "<table border=\"1\"><tr><td>";
		foreach my $row ($ts->rows) {
			print "", join("</td><td>", @$row), "\n";
			print "</td></tr><tr><td>";
		}
#	print "</td></tr><tr><td>";
	}
}
print "</td></tr></table>";
print "<a href='dell.txt'>sauce</a> <a href='..'>home</a> <a href='../wp/dell-warranty-info/'>non-cgi</a>";;
print "<html>";
