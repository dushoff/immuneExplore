use strict;
use 5.12.0;

$/ = "";

while(<>){
	my %rec;
	my @fields = split /\n/, $_;
	for my $f (@fields){
		next unless my ($tag, $text) = $f =~ /^([\w]+)\s*-\s+(.*)/;
		push @{$rec{$tag}}, $text;
	}
	for my $tag (keys %rec){
		$rec{$tag} = join " | ", @{$rec{$tag}};
	}

	## Punctuation is a pain
	$rec{TI} =~ s/\w$/$&./;
	## Location is a pain and does not match well
	push my @loc, $rec{VL} if defined $rec{VL};
	push my @page , $rec{SP} if defined $rec{SP};
	push @page, $rec{EP} if (defined $rec{EP} && $rec{EP} ne "+");
	my $page = join "-", @page;
	$page = $rec{C7} unless $page;
	push @loc, $page if $page;

	my $title = $rec{TI};

	## Identify correction syntax
	if ($title =~ /\([^)]*\bvol\b/){
		warn "SKIPPING title $title";
		next;
	}
	## Weird keywords
	$title =~ s/EBOLA Ebola/Ebola/;

	my $source = $rec{JO};
	$source = $rec{JI} if defined $rec{JI};
	$source =~ s/[.]//g;

	my $pub = $rec{PY};
	$pub =~ s/\s.*//;

	my $author = $rec{AU};
	$author =~ s/,//g;
	say "AU: $author";
	say "TI: $title";
	say "SO: $source";
	say "PUB: $pub";
	say "LOC: " . join ":", @loc;
	say "";
}

