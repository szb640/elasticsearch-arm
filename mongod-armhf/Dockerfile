FROM arm32v7/debian:jessie-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		wget binutils libssl-dev

RUN mkdir -p /usr/local/mongo \
    && wget http://andyfelong.com/downloads/core_mongodb.tar.gz -O mongo.tar.gz \
    && tar -xvzf mongo.tar.gz -C /usr/local/mongo \
    && rm mongo.tar.gz \
    && strip /usr/local/mongo/mongo*

RUN cp -p /usr/local/mongo/mongo* /usr/bin \
    && mkdir -p /var/log/mongodb \
    && mkdir -p /var/lib/mongodb \
    && chmod 755 /usr/local/mongo/mongo*

VOLUME /var/lib/mongodb /var/log/mongodb

COPY mongodb.conf /etc/mongodb.conf

EXPOSE 27017

CMD ["/usr/local/mongo/mongod", "--config", "/etc/mongodb.conf"]
