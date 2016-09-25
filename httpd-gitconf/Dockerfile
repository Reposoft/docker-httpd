
# TODO but we need openidc here too
FROM httpd-gitclient

# Needed during development at least
RUN mkdir -p /usr/local/lib/site_perl/Data \
  && curl http://api.metacpan.org/source/SMUELLER/Data-Dumper-2.161/Dumper.pm -o /usr/local/lib/site_perl/Data/Dumper.pm \
  && echo "c3d1692479123e7c21d3e47a08550fde6fcbcbdf /usr/local/lib/site_perl/Data/Dumper.pm" | sha1sum -c -

# Evaluated this logging lib
#RUN mkdir -p /usr/local/lib/site_perl/CGI \
#  && curl http://api.metacpan.org/source/JMOORE/CGI-Log-1.00/Log.pm -o /usr/local/lib/site_perl/CGI/Log.pm \
#  && echo "d02ad2ad622ee1953f51e0c74b9af52a94bb6d0b /usr/local/lib/site_perl/CGI/Log.pm" | sha1sum -c -

# Found a logging lib that is a simple abstraction on print and also replaces die, without the dependencies of Carp
RUN mkdir -p /usr/local/lib/site_perl/Scalar \
  && curl http://api.metacpan.org/source/PEVANS/Scalar-List-Utils-1.45/lib/Scalar/Util.pm -o /usr/local/lib/site_perl/Scalar/Util.pm \
  && echo "a85497bb2f8979b6eb76cfdc7bd7dc4bcc70b64e /usr/local/lib/site_perl/Scalar/Util.pm" | sha1sum -c - \
  && mkdir -p /usr/local/lib/site_perl/Term \
  && curl http://api.metacpan.org/source/RRA/Term-ANSIColor-4.05/lib/Term/ANSIColor.pm -o /usr/local/lib/site_perl/Term/ANSIColor.pm \
  && echo "07499818b26ab025d726e56b2c798cee14ad61a6 /usr/local/lib/site_perl/Term/ANSIColor.pm" | sha1sum -c - \
  && mkdir -p /usr/local/lib/site_perl/Log \
  && curl http://api.metacpan.org/source/KAZEBURO/Log-Minimal-0.19/lib/Log/Minimal.pm -o /usr/local/lib/site_perl/Log/Minimal.pm \
  && echo "917f7f526e286d7ae684d6a2e7468729d500f7a3 /usr/local/lib/site_perl/Log/Minimal.pm" | sha1sum -c -

COPY HttpdControl.pm /usr/local/lib/site_perl/
COPY ReconfDirGit.pm /usr/local/lib/site_perl/

COPY conf/cgi conf/cgi
# TODO include

COPY site_perl /usr/local/lib/site_perl
COPY reconf admin-cgi/

COPY httpd-reconf /usr/local/bin/
