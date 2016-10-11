FROM httpd-git

RUN sed -i 's|^#LoadModule authn_anon_module|LoadModule authn_anon_module|' conf/httpd.conf

COPY auth-anon.conf conf/git/

RUN mkdir -p /opt/git/Test \
  && git init --bare /opt/git/Test/test.git \
  && git init --bare /opt/git/Test/conf.git \
  && git init --bare /opt/git/Test/cert.git \
  && chown -R daemon /opt/git

RUN git config --global user.email "you@example.com" \
  && git config --global user.name "Your Name" \
  && git clone /opt/git/Test/conf.git /tmp/conf \
  && cd /tmp/conf/ \
  && cp /usr/local/apache2/conf/httpd.conf . \
  && cp /usr/local/apache2/conf/mime.types . \
  && sed -i 's/^Include/#Include/' httpd.conf \
  && git add * \
  && git commit -m "Gets httpd up and running" \
  && git push origin master
