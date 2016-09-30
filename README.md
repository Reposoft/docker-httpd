# Apache 2 `httpd` images

Derivatives of https://hub.docker.com/_/httpd/. Linux distros' httpd packages introduce config modularity that we don't need in Docker based hosting. The single `conf` folder with `httpd.conf` is more userful here.

These images are built to https://hub.docker.com/u/solsson/.

## `httpd:openidc`

Deprecated. See `solsson/httpd-openidc`.

## `httpd:letsencrypt`

Was designed for a specific hosting scenario. See limitations+caveats in cert-sync.

These days we tend to use https://github.com/Reposoft/docker-letsencrypt instead.

## `httpd:git`

Plain https://git-scm.com/book/en/v2/Git-on-the-Server-Smart-HTTP https://git-scm.com/docs/git-http-backend.
Read-only out of the box (push gets 403).
```
git init --bare git/TestOrg/repo.git
docker run -p 80:80 -v $(pwd)/git:/opt/git --name git-http -d solsson/httpd:git
git clone http://git-http/git/TestOrg/repo.git
```

Compiles all of git, but a lot of that can/should be removed.

## more

Other httpd based images in more specific repositories:

 * https://github.com/Reposoft/docker-svn/tree/master/httpd
