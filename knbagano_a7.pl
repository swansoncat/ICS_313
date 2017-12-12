use feature 'say';


say "Is this file a person or movie?";
my $category = <STDIN>;

while ($category ne "person\n" && category ne "movie\n")
{
	say "That isn't a valid category. Please enter either \'person\' or \'movie\'.";
	$category = <STDIN>;
}



my $file_name = 'jj_abrams.html';
my $write_file = 'database.pl';

open my $fh, '<', $file_name or die "Can't open read file: $_";
open my $fh_w, '>>', $write_file or die "Can't open write file: $_";

while (my $info = <$fh>) 
{
	chomp($info);
	if ($info =~ m/nm_flmg_dr/)
	{
		print "$info\n";
		print $fh_w "$info\n";
	}
}

close $fh or die "Unable to close: $_";
close $fh_w or die "Unable to close write file: $_";