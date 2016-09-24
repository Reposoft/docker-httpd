package HttpdControl;

use strict;
use warnings;

sub new {
  my ($class, %args) = @_;
  return bless { %args }, $class;
}

sub configtest {
  my ($self) = @_;
  my $out = `apachectl configtest`;
  my $result = $?;
  print $out;
  return $result == 0;
}

sub reload {
  my ($self) = @_;
  my $out = `apachectl graceful`;
  my $result = $?;
  print $out;
  return $result == 0;
}

1;
