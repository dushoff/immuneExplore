use strict;
use 5.10.0;

$/ = "";

while(<>){
	my %fields;
	my @lines = split /\n/, $_;
	foreach my $ln (@lines){
		next if /^#/;
		my ($t, $f) = $ln =~ /(\w*):\s*(.*)/;
		$fields{$t} = $f if $f;
	}
	say "@article{tag, ";
	say 

}

