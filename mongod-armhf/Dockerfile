FROM arm32v7/debian:jessie-slim

# Install GOSU
ENV GOSU_VERSION 1.10
RUN apt-get update -y && apt-get install wget -y \
    && set -x \
	&& wget -O /usr/local/bin/gosu "http://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "http://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

# Install dependencies
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
        binutils \
        libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Add mongo user
RUN groupadd -r mongo --gid=999 && useradd -r -g mongo --uid=999 mongo

# Download, extract, strip mongo core
RUN wget http://andyfelong.com/downloads/core_mongodb.tar.gz -O mongo.tar.gz \
    && tar -xvzf mongo.tar.gz -C /usr/bin \
    && rm mongo.tar.gz \
    && strip /usr/bin/mongo*

COPY mongodb.conf /etc/mongodb.conf

# Link tools, create dirs, set permissions
RUN mkdir -p /var/log/mongodb \
    && chown -R mongo:mongo /var/log/mongodb \
    && chmod -R 744 /var/log/mongodb \
    && mkdir -p /var/lib/mongodb \
    && chown -R mongo:mongo /var/lib/mongodb \
    && chmod -R 744 /var/lib/mongodb \
    && chmod 755 /usr/bin/mongo* \
    && chmod -R 744 /etc/mongodb.conf

VOLUME /var/lib/mongodb /var/log/mongodb

EXPOSE 27017
EXPOSE 28017

# Create entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh \
    && ln -s /usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["mongod", "--config", "/etc/mongodb.conf"]
