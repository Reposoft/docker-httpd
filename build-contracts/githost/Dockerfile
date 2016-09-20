FROM httpd-git

#RUN rm conf/git/git-readonly.conf

RUN mkdir -p /opt/git/Gitconf \
  && git init --bare /opt/git/Gitconf/conf.git \
  && git init --bare /opt/git/Gitconf/cert.git

RUN git config --global user.email "you@example.com" \
  && git config --global user.name "Your Name" \
  && git clone /opt/git/Gitconf/conf.git /tmp/conf \
  && cd /tmp/conf/ \
  && cp /usr/local/apache2/conf/httpd.conf /tmp/conf/ \
  && sed -i 's/^Include/#Include/' /tmp/conf/httpd.conf \
  && git add httpd.conf \
  && git commit -m "Gets httpd up and running" \
  && git push origin master
