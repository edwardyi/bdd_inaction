FROM php:8.1.12-fpm

# update and install swoole
RUN apt-get update \
    && apt-get install -y autoconf g++ make \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
    && apt-get remove -y autoconf g++ make \
    && apt-get clean

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install git
RUN apt-get update \
    && apt-get install -y git


# install npm
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -
RUN apt-get install -y nodejs

# install latest version npm
RUN npm install -g npm

# install javascript bdd
WORKDIR /var/www/html

# COPY all folder data
COPY . ./

# install npm
# RUN cd ./app/static/ && npm install

# install grpc
# RUN git clone -b v1.33.2 https://github.com/grpc/grpc \
#     && cd grpc \
#     && git submodule update --init \
#     && make grpc_php_plugin \
#     && cp bins/opt/grpc_php_plugin /usr/local/bin/ \
#     && cd .. \
#     && rm -rf grpc

CMD [ "php", "index.php" ]

EXPOSE 9000

# Install Selenium, Firefox, and Xvfb
RUN apt-get update && apt-get install -y \
    chromium \
    xvfb \
    openjdk-11-jre-headless \
    wget \
    && wget https://github.com/mozilla/geckodriver/releases/download/v0.29.1/geckodriver-v0.29.1-linux64.tar.gz \
    && tar -xf geckodriver-v0.29.1-linux64.tar.gz -C /usr/local/bin/ \
    && rm geckodriver-v0.29.1-linux64.tar.gz \
    && wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar \
    && mv selenium-server-standalone-3.141.59.jar /usr/local/bin/selenium-server-standalone.jar

# Add a script to start Selenium
COPY start-selenium.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-selenium.sh

# Expose the default Selenium port
EXPOSE 4444

# Run the start script when the container starts
CMD ["/usr/local/bin/start-selenium.sh"]

