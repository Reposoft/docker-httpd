#!/usr/bin/perl -w
use strict;

use Test::Spec;

my $testkey = time();
mkdir "/tmp/testrun-$testkey";
chdir "/tmp/testrun-$testkey";
print "# testrun /tmp/testrun-$testkey\n";

use HTTP::Tiny;

my $r;

describe "Httpd state at container startup" => sub {

  it "Should be running" => sub {
    $r = HTTP::Tiny->new->head('http://httpd/');
    is($r->{status}, 200);
  };

  it "Should have a typical 404 error page" => sub {
    $r = HTTP::Tiny->new->head('http://httpd/testing/notfound');
    is($r->{status}, 404);
    isnt($r->{content}, 'Custom.');
  };

};

describe "A shared git remote" => sub {

  it "Is alive" => sub {
    $r = HTTP::Tiny->new->head('http://githost/');
    is($r->{status}, 200);
  };

};



runtests unless caller;
