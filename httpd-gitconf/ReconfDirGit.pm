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
  ($? == 0) or croakf("Failed to read current rev: $rev");
  chomp($rev);
  return $rev;
}

sub branch {
  my ($self) = @_;
  my $branch = `cd $self->{dir} && git rev-parse --abbrev-ref HEAD`;
  $? == 0 or croakf("Failed to read current branch: $branch");
  chomp($branch);
  $branch or croakf("Falsey branch name at ".$self->rev());
  return $branch;
}

sub mark_good {
  my ($self) = @_;
  my $current = $self->branch();
  ($current =~ /^reconf_last-known-good_/) and die("Invalid state. Current branch is the checkpoint $current");
  debugf(`cd $self->{dir} && git checkout -B _reconf_last-known-good_$current && git checkout $current`);
  ($? == 0) or croakf('Branch last good conf failed at $current');
  debugf("_reconf_last-known-good_$current saved at ".$self->rev());
}

sub fetch_rebase {
  my ($self) = @_;
  my $rev = $self->rev();
  my $current = $self->branch();
  debugf("cd $self->{dir} && git rev-parse --verify $self->{remote}/$current");
  my $remoterev = `cd $self->{dir} && git rev-parse --verify $self->{remote}/$current`;
  chomp($remoterev);
  ($rev eq $remoterev) or croakf("Local rev $rev is out of sync with $self->{remote}/$current $remoterev");
  debugf("$current == $self->{remote}/$current == $rev");
  debugf(`cd $self->{dir} && git fetch $self->{remote} && git rebase $self->{remote}/$current`);
  ($? == 0) or croakf("Fetch + rebase failed for $self->{remote}/$current");
}

sub revert_to_good {
  my ($self) = @_;
  my $current = $self->branch();
  ($current =~ /^reconf_last-known-good_/) and die("Current branch is already at the checkpoint $current");
  debugf(`cd $self->{dir} && git checkout _reconf_last-known-good_$current && git checkout -B $current`);
  ($? == 0) or croakf("Revert failed. Now at ".$self->rev());
}

1;
