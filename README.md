# Apache 2 `httpd` images

Derivatives of https://hub.docker.com/_/httpd/. Linux distros' httpd packages introduce config modularity that we don't need in Docker based hosting. The single `conf` folder with `httpd.conf` is more userful here.

These images are built to https://hub.docker.com/u/solsson/.

## `httpd:openidc`

Includes https://github.com/pingidentity/mod_auth_openidc/.

## `httpd:letsencrypt`

Was designed for a specific hosting scenario. See limitations+caveats in cert-sync.

These days we tend to use https://github.com/Reposoft/docker-letsencrypt instead.

## more

Other httpd based images in more specific repositories:

 * https://github.com/Reposoft/docker-svn/tree/master/httpd
