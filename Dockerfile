FROM ruby:2.5.3-alpine
MAINTAINER xbulat <xbulat@github.com>
LABEL Description="QnA" \
      Vendor="GitHub" \
      Version="1.0"

ENV BUNDLE_JOBS=3        \
    BUNDLE_PATH=/bundle  \
    GEM_HOME=/bundle

ARG DEV_PACKAGES="build-base linux-headers ruby-bundler ruby-dev ruby-nokogiri"
ARG PACKAGES="openssl ca-certificates tzdata nodejs bash git wget mysql-dev libxml2-dev libxslt-dev"
ARG SECRET_KEY_BASE

WORKDIR /app

RUN apk --no-cache --update add $PACKAGES
RUN apk --no-cache --update add --virtual build-dependencies $DEV_PACKAGES

COPY Gemfile* ./

RUN bundle install \
    && apk del build-dependencies

COPY . .
COPY config/database.yml.deploy config/database.yml
RUN bundle exec rake assets:precompile RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY_BASE

EXPOSE 3000
ENTRYPOINT [ "bundle", "exec" ]
