FROM perl:5.24

# http://stackoverflow.com/questions/3462058/how-do-i-automate-cpan-configuration
RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit) | cpan

RUN cpan install Test::Spec

RUN cpan install HTTP::Tiny JSON

# We need one of these and I don't know which one is more stable or useful yet
# To evaluate, toggle entrypoint between prove/autoprove/prowess
RUN cpan install Test::Continuous App::prowess

RUN git --version && cpan install Git::Wrapper

RUN git config --global user.email "perlspec-testing@example.com" \
  && git config --global user.name "Perlspec Testint"

# Official perl image gotcha, /usr/bin/perl fails to include CPAN modules
RUN mv /usr/bin/perl /usr/bin/perl.org \
  && ln -s /usr/local/bin/perl /usr/bin/perl

WORKDIR /project

ENTRYPOINT ["prove"]
