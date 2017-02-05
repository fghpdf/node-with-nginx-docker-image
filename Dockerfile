FROM ubuntu:16.04

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
    echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list && \
    apt-get update
# install build tool
RUN apt-get install curl -y

# install node
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install -y nodejs

# install nginx
RUN apt-get install -y ca-certificates nginx && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    mkdir -p app