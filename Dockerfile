
FROM httpd:2.4.18

# wget https://github.com/letsencrypt/letsencrypt/archive/v0.3.0.tar.gz
ADD v0.3.0.tar.gz /usr/local/

# Does a lot of package installations that we don't want at runtime.
# Prints a "No installers" error but that's normal.
RUN cd /usr/local/letsencrypt-0.3.0 \
  && ./letsencrypt-auto; exit 0

RUN ln -s /root/.local/share/letsencrypt/bin/letsencrypt /usr/local/bin/letsencrypt

COPY bin/* /usr/local/bin/

ENV cert_delay=1
ENV cert_single=true
# Commented out because we don't want defaults
#ENV cert_domains
#ENV cert_email
#ENV LETSENCRYPT_ENDPOINT
