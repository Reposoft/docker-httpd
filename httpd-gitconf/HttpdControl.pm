package HttpdControl;

use strict;
use warnings;

use Log::Minimal env_debug => 'DEBUG';

sub new {
  my ($class, %args) = @_;
  return bless { %args }, $class;
}

sub configtest {
  my ($self) = @_;
  my $out = `apachectl configtest`;
  my $result = $?;
  chomp($out);
  debugf($out);
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
