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
my @acts_in;

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
		$title =~ s/ /_/g;
		$title =~ s/\.//g;
		$title =~ s/-//g;
		$title =~ s/!//g;
		$title =~ s/\'//g;
		$title =~ s/://g;
		$title = lc $title;
		if ($category eq "movie")
		{
			if ($title =~ m/([0123456789]{4})/)
			{
				$date_start = index $title, "(";
				$title = substr $title, 0, $date_start - 1;
				print "The title is: $title\n";
			}
		}
	}
	
	
	#This is the code for webpages about persons.
	if ($category eq "person")
	{
		
		if ($info =~ m/nm_flmg_dr/ && $info =~ m/<b>/)
		{
			my $length = length $info;		
			my $substr = substr $info, 40, $length - 40;
			my $start_index = index $substr, ">";
			my $end_index = index $substr, "<";
			$substr = substr $substr, $start_index + 1, $end_index - $start_index - 1;
			$substr =~ s/ /_/g;
			$substr =~ s/\.//g;
			$substr =~ s/-//g;
			$substr =~ s/!//g;
			$substr =~ s/\'//g;
			$substr =~ s/://g;
			$substr = lc $substr;
			print "$substr\n";
			print $fh_w "directed($title, $substr).\n";
		}
		
		if ($info =~ m/nm_flmg_act/ && $info =~ m/<b>/)
		{
			my $length = length $info;		
			my $substr = substr $info, 40, $length - 40;
			my $start_index = index $substr, ">";
			my $end_index = index $substr, "<";
			$substr = substr $substr, $start_index + 1, $end_index - $start_index - 1;
			$substr =~ s/ /_/g;
			$substr =~ s/\.//g;
			$substr =~ s/-//g;
			$substr =~ s/!//g;
			$substr =~ s/\'//g;
			$substr =~ s/://g;
			$substr = lc $substr;
			print "$substr\n";
			print $fh_w "acts_in($title, $substr).\n";
		}
	}
	
	
	#This is the code for webpages about movies.
	if ($category eq "movie")
	{
		#This intial block of code gets the director for the movie
		if ($info =~ m/itemprop="director"/) 
		{
			$info = <$fh>;
			my $length = length $info;		
			my $substr = substr $info, 55, $length - 55;
			my $start_index = index $substr, "itemprop=\"name\"";
			my $end_index = index $substr, "</span";
			$substr = substr $substr, $start_index + 16, $end_index - $start_index - 16;
			$substr =~ s/ /_/g;
			$substr =~ s/\.//g;
			$substr =~ s/-//g;
			$substr =~ s/!//g;
			$substr =~ s/\'//g;
			$substr =~ s/://g;
			$substr = lc $substr;
			print $fh_w "directed($substr, $title).\n";
		}
		
		#This block of code gets the actors in the movie.
		if ($info =~ m/itemprop="actor"/) 
		{
			#This block of code writes the acts_in(actor, movie) into the database.
			$info = <$fh>;
			my $length = length $info;		
			my $substr = substr $info, 55, $length - 55;
			my $start_index = index $substr, "itemprop=\"name\"";
			my $end_index = index $substr, "</span";
			$substr = substr $substr, $start_index + 16, $end_index - $start_index - 16;
			$substr =~ s/ /_/g;
			$substr =~ s/\.//g;
			$substr =~ s/-//g;
			$substr =~ s/!//g;
			$substr =~ s/\'//g;
			$substr =~ s/://g;
			$substr = lc $substr;
			push @acts_in, "acts_in($substr, $title).\n";
			#print $fh_w "acts_in($substr, $title).\n";
			my $actor = $substr;
			
			
			#This block of code writes in the play(actor, character) into the database. This works by the knowledge that immediately after the actor name is a line with the text 
			# 'class="character"' which the program uses to know where to find the character information. The character's name is 2 lines below the prior mentioned line.
			#There are 3 if conditions that the code checks for. The line with the name can either have nothing on it or the text 'm/tt_cl_t/'. There are two if conditions because the
			#indices of the names will change if the text 'm/tt_cl_t/' has a number with 1 or 2 digits immediatly after it.
			$info = <$fh>;
			while (!($info =~ m/class="character"/))
			{
				$info = <$fh>;
			}
			$info = <$fh>;
			$info = <$fh>;
			if ($info =~ m/tt_cl_t1[0123456789]/)
			{
				$length = length $info;		
				$substr = substr $info, 50, $length - 50;
				$start_index = index $substr, "tt_cl_t";
				$end_index = index $substr, "</a>";
				$substr = substr $substr, $start_index + 11, $end_index - $start_index - 11;
				$substr =~ s/ /_/g;
				$substr =~ s/\.//g;
				$substr =~ s/-//g;
				$substr =~ s/!//g;
				$substr =~ s/\'//g;
				$substr =~ s/://g;
				$substr = lc $substr;
				print "$substr\n";
				print $fh_w "play($actor, $substr).\n";
			} 
			elsif ($info =~ m/tt_cl_t/)
			{
				$length = length $info;		
				$substr = substr $info, 50, $length - 50;
				$start_index = index $substr, "tt_cl_t";
				$end_index = index $substr, "</a>";
				$substr = substr $substr, $start_index + 10, $end_index - $start_index - 10;
				$substr =~ s/ /_/g;
				$substr =~ s/\.//g;
				$substr =~ s/-//g;
				$substr =~ s/!//g;
				$substr =~ s/\'//g;
				$substr =~ s/://g;
				$substr = lc $substr;
				print "$substr\n";
				print $fh_w "play($actor, $substr).\n";
			}
			else
			{
				$length = length $info;	
				$info =~ s/ {2,}//g;
				$start_index = index $info, "[:alpha:]";
				$end_index = rindex $info, "[:alpha:]";
				$substr = substr $info, $start_index + 1, $end_index - $start_index - 1;		
				$substr =~ s/ /_/g;
				$substr =~ s/\.//g;
				$substr =~ s/-//g;
				$substr =~ s/!//g;
				$substr =~ s/\'//g;
				$substr =~ s/://g;
				$substr = lc $substr;
				chop($substr);
				print "$substr\n";
				print $fh_w "play($actor, $substr).\n";
			}

		}
	}
}
my $acts_in = shift @acts_in;
while ($acts_in)
{
	print $fh_w $acts_in;
	$acts_in = shift @acts_in;
}

close $fh or die "Unable to close read file: $_";
close $fh_w or die "Unable to close write file: $_";


