package HttpdReconf;
use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(refresh configtest reload);

my $httpdhome = '/usr/local/apache2';

sub refresh {
  `cd $httpdhome/conf; git pull --rebase`;
  $? == 0 or return 0;
  #if (-e "$httpdhome/cert" and -d "$httpdhome/cert") {
  #  `cd $httpdhome/cert; git pull --rebase`;
  #  $? == 0 or return 0;
  #}
  return 1;
};

sub configtest {
  print "Configtest!\n";
};

sub reload {
  print "Reload!\n"
};

1;
