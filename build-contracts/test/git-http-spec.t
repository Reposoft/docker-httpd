#!/usr/bin/perl -w
use strict;

use Test::Spec;

# Didn't like this much, let's see if we need it
#use Git::Wrapper;
#my $git = Git::Wrapper->new('/tmp/test');

my $testkey = time();
mkdir "/tmp/testrun-$testkey";
chdir "/tmp/testrun-$testkey";
print "# testrun /tmp/testrun-$testkey\n";

describe "Clone at /git/[org]/[repo]" => sub {

  it "Allowed" => sub {
    `git clone http://githost/git/Test/test.git ./test`;
    is($?, 0);
  };

  it "Produces a local repo" => sub {
    ok(-e 'test/.git' and -d 'test/.git');
  };

};

describe "Readonly" => sub {

  it "Same clone behavior as regular host" => sub {
    `git clone http://readonly/git/Test/test.git ./readonly`;
    is($?, 0);
  };

  it "Same fetch" => sub {
    `cd test/ && git remote add readonly http://readonly/git/Test/test.git && git fetch readonly`;
    is($?, 0);
  };

  it "Denies push" => sub {
    `cd test/ && echo test > test1.txt && git add test1.txt && git commit -m "Test 1"`;
    is($?, 0);
    `cd test/ && git push readonly master`;
    isnt($?, 0);
  };

  # TODO test for status code 403 at GET /git/Test/test.git/info/refs?service=git-receive-pack
  # as the test above passes for status 500 (i.e. auth not configured) too
  # Or we can possibly just check for git auth attempt "fatal: could not read Username for 'http://readonly': No such device or address"

};

describe "Push" => sub {

  it "Requires authentication (with default config, custom auth conf needed)" => sub {
    `cd test/ && git push origin master`;
    isnt($?, 0);
  };

  it "Test container runs mod_auth_anon so any username will do here" => sub {
    `cd test/ && git remote add auth 'http://testuser:\@githost/git/Test/test.git' && git remote -v`;
    ## more presistent auth
    #`echo 'http://testuser:@githost' >> ~/.git-credentials`
    #`cd test/ && git config credential.helper store && git push origin master`;
    is($?, 0);
  };

};

runtests unless caller;
