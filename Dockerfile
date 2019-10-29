FROM ruby:2.6-alpine
LABEL maintainer="Digital-Learner"

RUN apk update && \
    apk upgrade && \
    apk --no-cache add build-base && \
    apk --no-cache add openssh-client && \
    apk add --no-cache bash && \
    apk add --no-cache gmp-dev && \
    apk add --no-cache zlib-dev && \
    apk add --no-cache libressl-dev && \
    apk add --no-cache gdbm-dev && \
    apk add --no-cache db-dev && \
    apk add --no-cache readline-dev && \
    apk add --no-cache libffi-dev && \
    apk add --no-cache coreutils && \
    apk add --no-cache yaml-dev && \
    apk add --no-cache linux-headers && \
    apk add --no-cache autoconf && \
    apk --no-cache add vim && \
    rm -rf /var/cache/apk/*

RUN gem install bundler

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app

RUN bundle install

COPY . /usr/src/app/

CMD ["bin/bash"]