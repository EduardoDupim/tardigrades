#!/usr/bin/perl 
#===========================================================================
#
#         FILE: recover_Kmers.pl
#        USAGE: perl recover_Kmers.pl [target library jellyfish dump file] [genomic reads jellyfish dump file] >[rc histo file]
#               genomic reads standard: /n/hsphS10/hsphfs4/lemos_lab/edupim/Hyp_genomes/NCarolina/Chicago_curated_genome/Hyp_pe_Lemos_mapped_m15q10.dump
#       AUTHOR: developed by Eduardo Dupim (edudupim@gmail.com), written Wang Meng (mengwang55@gmail.com)
#      VERSION: 1.0
#      CREATED: 06/23/2016 05:12:27 PM
#===========================================================================

use strict;
use warnings;

my ($file1,$file2)=@ARGV;
open I_tr,$file1; #"./Hyp-Delbem_transcriptome_assemb_m15.dump";
my (%tran,%dup);
while(<I_tr>){
    chomp;
    my @row = split;
    $tran{$row[0]} = $row[1];
}

open I_g,$file2; #"/n/hsphS10/hsphfs4/lemos_lab/edupim/Hyp_genomes/NCarolina/Chicago_curated_genome/Hyp_pe_Lemos_mapped_m15q10.dump";
while(<I_g>){
    chomp;
    my @row = split;
    if($tran{$row[0]}){
        $dup{$row[0]} = 1;
        print join("\t",$_,"Genome"),"\n";
    }
}

open I_tr2,$file1; #"<./Hyp-Delbem_transcriptome_assemb_m15.dump";
while(<I_tr2>){
    chomp;
    my @row = split;
    print join("\t",$_,"Transcript"),"\n" unless $dup{$row[0]};
}
