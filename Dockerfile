FROM centos:6

RUN yum update --assumeyes && \
  yum install --assumeyes \
    httpd \
    php php-cli php-common php-devel php-gd php-mbstring php-mcrypt php-mysql \
    php-pdo php-soap php-xml mod_ssl git && \
    ln -sf /dev/stderr /var/log/httpd/error_log

RUN mkdir /tmp/rpaf; cd /tmp/rpaf; git clone https://github.com/gnif/mod_rpaf.git . && \
  yum install --assumeyes httpd-devel gcc && make && make install

RUN groupadd -g 5500 ftp2 && usermod -G ftp2 apache && usermod -G ftp2 ftp

COPY httpd-foreground /usr/local/bin/

EXPOSE 80 443
CMD ["httpd-foreground"]
