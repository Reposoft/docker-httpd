#!/usr/bin/perl -w
use strict;

use Httpd-Conf-Reload;


# timestamp
RUNLABEL=()

# keep current config state for undo
for (d in conf cert)
  git checkout -b previous-$RUNLABEL

function rollback

# test config
apachectl configtest || rollback

apachectl graceful || rollback