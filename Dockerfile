FROM nginx:latest

COPY Dockerfile /Dockerfile
COPY etc/. /etc
COPY usr/share/nginx/html/. /usr/share/nginx/html

# install packages
RUN apt-get update
RUN apt-get install -y nano wget supervisor imagemagick graphicsmagick php7.3-cli php7.3-common php7.3-curl php7.3-gd php7.3-imap php7.3-intl php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-readline php7.3-soap php7.3-xml php7.3-zip php7.3-pgsql php-sqlite3 php7.3-fpm
RUN apt-get clean

# run php to create /run/php/php7.3-fpm.pid for supervisor
RUN service php7.3-fpm start

# download and copy typo3
WORKDIR /root
RUN mkdir setup
WORKDIR /root/setup

RUN wget --content-disposition https://get.typo3.org/10.4.9 -O typo3.tar.gz
RUN tar xzf typo3.tar.gz
RUN cp -r typo3_src-10.4.9/. /usr/share/nginx/html

WORKDIR /root
RUN rm -r setup

RUN touch /usr/share/nginx/html/FIRST_INSTALL

RUN usermod -aG www-data nginx
RUN chown -R www-data:www-data /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html

VOLUME /usr/share/nginx/html

EXPOSE 80

CMD ["/usr/bin/supervisord"]