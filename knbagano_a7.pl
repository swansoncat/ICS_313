#This is the file for ICS 313 Assignment 7. This is a Perl program that reads html files and outputs certain data out into a database in a Prolog file.
#This file takes one command line argument which tells  the program what file to read from. The content of the html file is determined by asking the user
#at the start of the program (The program asks whether or not the webpage is on a person or movie. It asks person rather than actor or director because
# a person could be both.

use feature 'say';


#This initial code finds out what kind of data is in the webpage.
say "Is this file a person or movie?";
my $category = <STDIN>;
chomp($category);
while ($category ne "person" && $category ne "movie")
{
	say "That isn't a valid category. Please enter either \'person\' or \'movie\'.";
	$category = <STDIN>;
	chomp($category);
}



my $file_name = $ARGV[0];
my $write_file = 'database.pl';
my $title; #name of person or movie

open my $fh, '<', $file_name or die "Can't open read file: $_";
open my $fh_w, '>>', $write_file or die "Can't open write file: $_";


#This section of code does the work of finding the data in the html file.
while (my $info = <$fh>) 
{
	chomp($info);
	
	#This section of code finds the name of the person or the movie that the webpage is about.
	if ($info =~ m/<title>/)
	{
		my $title_index = index $info, ">";
		my $title_end = index $info, "IDMB";
		$title = substr $info, $title_index + 1, $title_end - $title_index;
	}
	
	
	if (category eq "person")
	{
		if ($info =~ m/nm_flmg_dr/ && $info =~ m/<b>/)
		{
			my $length = length $info;		
			my $substr = substr $info, 40, $length - 40;
			my $start_index = index $substr, ">";
			my $end_index = index $substr, "<";
			$substr = substr $substr, $start_index + 1, $end_index - $start_index - 1;
			print "$substr\n";
			print $fh_w "directed($title, $substr)\n";
		}
		
		if ($info =~ m/nm_flmg_act/ && $info =~ m/<b>/)
		{
			my $length = length $info;		
			my $substr = substr $info, 40, $length - 40;
			my $start_index = index $substr, ">";
			my $end_index = index $substr, "<";
			$substr = substr $substr, $start_index + 1, $end_index - $start_index - 1;
			print "$substr\n";
			print $fh_w "acts_in($title, $substr)\n";
		}
	}
	
	if ($category eq "movie")
	{
		if ($info =~ m/itemprop="director"/) 
		{
			$info = <$fh>;
			my $length = length $info;		
			my $substr = substr $info, 55, $length - 55;
			my $start_index = index $substr, "itemprop=\"name\"";
			my $end_index = index $substr, "</span";
			$substr = substr $substr, $start_index + 16, $end_index - $start_index - 16;
			print "$substr\n";
			print $fh_w "directed($substr, $title)\n";
		}
		
		if ($info =~ m/itemprop="actor"/) 
		{
			$info = <$fh>;
			my $length = length $info;		
			my $substr = substr $info, 55, $length - 55;
			my $start_index = index $substr, "itemprop=\"name\"";
			my $end_index = index $substr, "</span";
			$substr = substr $substr, $start_index + 16, $end_index - $start_index - 16;
			print "$substr\n";
			print $fh_w "acts_in($substr, $title)\n";
		}
	}
	
	
}

close $fh or die "Unable to close read file: $_";
close $fh_w or die "Unable to close write file: $_";



