#!/usr/bin/perl -w
# renames all mame roms to appropriate name given in gamelist.txt
# use like this:
# cat gamelist.txt | perl rename_mame_roms.pl
use strict;
use warnings;

my $extension = ".zip";

while(my $line = <>){
	if($line =~ /^(\w+)\s+\"(.*?)\"\s*$/){
		my $old_name = $1 . $extension;
		my $new_name = $2;
		
		# Replace illegal filename characters (windows and linux) with a '-'
		# This character class will match: \ / < > : " | * ? ! @ + 
		$new_name =~ s/[\\\/<>:"|*?!@+]+/-/g;

		# Change spaces to underscores
		$new_name =~ s/\s+/_/g;

		$new_name = $new_name . $extension;
		print "[+] Renaming $old_name to $new_name\n";
		unless(rename($old_name,$new_name)){
			print "[-] Couldn't rename $old_name to $new_name\n";
		}
	}
}
