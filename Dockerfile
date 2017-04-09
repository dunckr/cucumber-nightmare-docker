FROM node:7

RUN apt-get update && apt-get install -y --no-install-recommends \
	libgtk2.0-0 \
	libgconf-2-4 \
	libasound2 \
	libxtst6 \
	libxss1 \
	libnss3 \
	xvfb

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
	yarn

ENV DISPLAY :0

WORKDIR /app
