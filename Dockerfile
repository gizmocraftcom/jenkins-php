FROM jenkins/jenkins:lts

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN mkdir -p ~/.ssh/

#install php cli
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y software-properties-common ca-certificates apt-transport-https apt-utils vim rsync \
       libxml2-utils \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
    && echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y php7.2-cli php7.2-bcmath php7.2-bz2 php7.2-curl php7.2-gd php7.2-json php7.2-mbstring \
                          php7.2-mysql php7.2-opcache php7.2-readline php7.2-soap php7.2-xml php7.2-zip


#setup node
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh \
    && chmod +x nodesource_setup.sh \
    && ./nodesource_setup.sh \
    && apt-get install -y nodejs


RUN ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts
RUN ssh-keyscan -t rsa foerdermanager.net >> ~/.ssh/known_hosts

# install composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer




