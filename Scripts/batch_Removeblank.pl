#!/usr/bin/perl
#Lauren Eserman 2022 - Edited from the batch_raxml.pl script from Karolina Heyduk (2014) reads2trees pipeline

#input = Gblocks cleaned alignments
#Usage: perl batch_Removeblank.pl gb
#This will create fasta files with the ending .mod that have any blank sequences removed

use strict;
use Cwd;
use Bio::SeqIO;
use Array::Utils qw(:all);


my $ending = $ARGV[0];
my @files = glob("*$ending");
my $wd = getcwd;


for my $file (@files) {
    open OUT, ">>$file.mod";
    my $geneID;
    my @headers;
    my $stop = 0;
    my $infile = Bio::SeqIO -> new(-file => "$file", -format => "fasta", -alphabet => "DNA"); 
    while (my $io_obj = $infile -> next_seq() ) {
	my $header = $io_obj->id();
	my $seq = $io_obj->seq();
	push(@headers, $header);
	if ($seq ~~ /[ACTG]/) {
	    print OUT ">$header\n$seq\n"; #makes a modified file that removes blank sequences
	}
	else {
	    next;
	}
    }
    close OUT;
}    
