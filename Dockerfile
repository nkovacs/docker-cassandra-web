FROM ruby:2.5

RUN apt-get update && \
	apt-get install -y netcat --no-install-recommends && \
	rm -rf /var/lib/apt/lists/*

RUN gem install cassandra-web

ADD entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
