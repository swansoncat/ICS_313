use feature 'say';


say "Is this file a person or movie?";
my $category = <STDIN>;
chomp($category);

while ($category ne "person" && category ne "movie")
{
	say "That isn't a valid category. Please enter either \'person\' or \'movie\'.";
	$category = <STDIN>;
	chomp($category);
}



my $file_name = 'jj_abrams.html';
my $write_file = 'database.pl';

my $title;

open my $fh, '<', $file_name or die "Can't open read file: $_";
open my $fh_w, '>>', $write_file or die "Can't open write file: $_";

while (my $info = <$fh>) 
{
	chomp($info);
	if ($info =~ m/<title>/)
	{
		my $title_index = index $info, ">";
		my $title_end = index $info, "IDMB";
		$title = substr $info, $title_index + 1, $title_end - $title_index;
	}
	
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

close $fh or die "Unable to close: $_";
close $fh_w or die "Unable to close write file: $_";



