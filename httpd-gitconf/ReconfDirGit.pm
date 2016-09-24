package ReconfDirGit;

use strict;
use warnings;

use Log::Minimal env_debug => 'DEBUG';

sub new {
  my ($class, %args) = @_;
  return bless { %args }, $class;
}

sub dir {
  my ($self) = @_;
  return $self->{dir};
}

sub rev {
  my ($self) = @_;
  my $rev = `cd $self->{dir} && git rev-parse --verify HEAD`;
  ($? == 0) or die('TODO throw exception instead');
  chomp($rev);
  return $rev;
}

sub branch {
  my ($self) = @_;
  my $branch = `cd $self->{dir} && git rev-parse --abbrev-ref HEAD`;
  $? == 0 or die('Failed to read current branch');
  chomp($branch);
  return $branch;
}

sub mark_good {
  my ($self) = @_;
  my $current = $self->branch();
  debugf(`cd $self->{dir} && git checkout -B reconf-last-known-good-configuration && git checkout $current`);
  ($? == 0) or die('TODO throw exception instead');
}

sub pull_rebase {
  my ($self) = @_;
  my $rev = $self->rev();
  my $current = $self->branch();
  debugf("cd $self->{dir} && git rev-parse --verify $self->{remote}/$current");
  my $remoterev = `cd $self->{dir} && git rev-parse --verify $self->{remote}/$current`;
  chomp($remoterev);
  ($rev eq $remoterev) or croakf("Local rev $rev is out of sync with $self->{remote}/$current $remoterev");
  debugf("$current == $self->{remote}/$current == $rev");
  `cd $self->{dir} && git fetch $self->{remote} && git rebase $self->{remote}/$current`;
  ($? == 0) or croakf('TODO throw exception instead');
}

1;
