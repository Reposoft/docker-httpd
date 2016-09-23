#!/usr/bin/perl -w
use strict;

use Test::Spec;

my $testkey = time();
mkdir "/tmp/testrun-$testkey";
chdir "/tmp/testrun-$testkey";
print "# testrun /tmp/testrun-$testkey\n";

use HTTP::Tiny;
use JSON;

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

  it "Has a conf repo to clone" => sub {
    `git clone http://githost/git/Test/conf.git`;
    is($?, 0);
    ok(-e 'conf/.git');
  };

  it "Has a cert repo to clone" => sub {
    `git clone http://githost/git/Test/cert.git`;
    is($?, 0);
    ok(-e 'conf/.git');
  };

};

describe "Extenal conf modification over git" => sub {

  it "Add a simple one liner that can be detected over HTTP" => sub {
    `echo '<Location /testing>ErrorDocument 404 "Custom."</Location>' >> conf/httpd.conf`;
    is($?, 0);
    `cd conf/; git add httpd.conf; git commit -m "Change 404 page"`;
    is($?, 0);
  };

  it "Trigger httpd reconf using REST endpoint" => sub {
    my $http = HTTP::Tiny->new();
    my $r = $http->post(
      'http://httpd/admin/reconf' => {
        content => to_json(
          {}
        ),
        headers => {
          'Accept' => 'application/json',
        },
      },
    );
    is($r->{status}, 200);
  };

  it "Shuld now have affected httpd's runtime conf" => sub {
    $r = HTTP::Tiny->new->head('http://httpd/testing/notfound');
    is($r->{content}, 'Custom.');
  };

};



runtests unless caller;
