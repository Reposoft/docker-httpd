FROM httpd-gitclient

RUN sed -i 's|#LoadModule cgid_module|LoadModule cgid_module|' conf/httpd.conf \
  && sed -i 's|#LoadModule rewrite_module|LoadModule rewrite_module|' conf/httpd.conf \
  && echo "Include conf/git/*.conf" >> conf/httpd.conf

ENV GIT_PROJECT_ROOT="/opt/git"
ENV GIT_HTTP_EXPORT_ALL="1"
ENV GIT_READONLY=""

ADD conf/git.conf /usr/local/apache2/conf/git/
ADD conf/git-access.conf /usr/local/apache2/conf/git/
