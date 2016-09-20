
FROM httpd:2.4.23

ENV GIT_VERSION 2.10.0
ENV GIT_VERSION_TGZ_URL https://www.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.gz
ENV GIT_VERSION_TGZ_SHA1 2d588afe7adb11ea11e0787c4a2f01329a0f2f55

RUN depsRuntime=' \
		libcurl3 \
		libcurl3-gnutls \
		curl \
		libexpat1 \
		gettext \
		libssl1.0.0 \
	' \
  && depsBuild=' \
		curl ca-certificates \
		gcc \
		make \
		autoconf \
		libcurl4-gnutls-dev \
		libexpat1-dev \
		gettext \
		libz-dev \
		libssl-dev \
	' \
	set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $depsRuntime \
	&& apt-get install -y --no-install-recommends $depsBuild \
	&& rm -r /var/lib/apt/lists/* \
	&& curl -SL "$GIT_VERSION_TGZ_URL" -o git-$GIT_VERSION.tar.gz \
	&& echo "$GIT_VERSION_TGZ_SHA1 git-$GIT_VERSION.tar.gz" | sha1sum -c - \
	&& mkdir -p src/git \
	&& tar -xvf git-$GIT_VERSION.tar.gz -C src/git --strip-components=1 \
	&& rm git-$GIT_VERSION.tar.gz* \
	&& cd src/git \
	&& make configure \
	&& ./configure --prefix=/usr \
	&& make all \
	&& make install \
	&& cd ../../ \
	&& rm -r src/git \
	&& apt-get purge -y --auto-remove $depsBuild

EXPOSE 80
