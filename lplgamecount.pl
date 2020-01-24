use strict;
use warnings;
use Term::ProgressBar;

#init
my $directory = "";
my $substringh = "-h";
my @linesf;

#check command line
foreach my $argument (@ARGV) {
  if ($argument =~ /\Q$substringh\E/) {
    print "lplgamecount v0.5 - Count the number of games in your playlist files. \n";
	print "\n";
	print "with lplgamecount [directory ...]";
    print "\n";
	print "Example:\n";
	print '              lplgamecount "D:/RetroArch/playlists"' . "\n";
	print "\n";
	print "Author:\n";
	print "   Discord - Romeo#3620\n";
	print "\n";
    exit;
  }
}

#set directory and system variables
if (scalar(@ARGV) < 1 or scalar(@ARGV) > 1) {
  print "Invalid command line.. exit\n";
  print "use: lplgamecount -h\n";
  print "\n";
  exit;
}
$directory = $ARGV[-1];

#debug
print "directory: $directory\n";

#exit no parameters
if ($directory eq "") {
  print "Invalid command line.. exit\n";
  print "use: dosdir2lpl -h\n";
  print "\n";
  exit;
}

#read playlist files from directory
my $dirname = $directory;
opendir(DIR, $dirname) or die "Could not open $dirname\n";
while (my $filename = readdir(DIR)) {
  push(@linesf, $filename) unless $filename eq '.' or $filename eq '..';
  #print "$filename\n";
}
closedir(DIR);

my $lplpath;
my $lplfile;
my $playlistnum = 0;
my $totalnum = 0;

#loop though each playlist and count
HASH: foreach my $element (@linesf) {
  #$progress->update($_);
  $lplpath = "$directory" . "\\" . "$element";
  $playlistnum = 0;
  if (-d $lplpath)
  {
  
  } else {
    #print "$lplpath\n";
    open (my $fh, '<:raw', $lplpath) or die "Could not open file '$lplpath' $!";
	while ($lplfile = <$fh>) {
      if ($lplfile eq '.' or $lplfile eq '..') {
          next;
      }
	  if ($lplfile =~ m/"label":/) {
	    $playlistnum = $playlistnum + 1; 
		#print "$lplfile\n";
      }
    }
    close $fh;
    print "playlist: " . $lplpath . "    games: " . $playlistnum . "\n";  
  }
  $totalnum = $totalnum + $playlistnum
}

print "\n";
print "total games: " . $totalnum . "\n";