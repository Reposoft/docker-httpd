FROM perl:5.24

# http://stackoverflow.com/questions/3462058/how-do-i-automate-cpan-configuration
RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit) | cpan

RUN cpan install Test::Spec

RUN git --version && cpan install Git::Wrapper

RUN git config --global user.email "perlspec-testing@example.com" \
  && git config --global user.name "Perlspec Testint"

# gotcha, /usr/bin/perl fails to include CPAN modules
ENTRYPOINT ["/usr/local/bin/perl", "-w"]
