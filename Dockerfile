ARG RUBY_VERSION=3.0-alpine

# build
FROM ruby:${RUBY_VERSION} AS build

RUN apk add --update \
    alpine-sdk

WORKDIR /build
ADD . .

RUN bundle install && \
  bundle exec rake build

# install
FROM ruby:${RUBY_VERSION} AS install

WORKDIR /build

COPY --from=build /build/pkg/f1_calendar_dashlet-*.gem .

RUN apk add --update \
    alpine-sdk \
  && \
  gem install f1_calendar_dashlet-*.gem

# run
FROM ruby:${RUBY_VERSION} AS run

WORKDIR /app

COPY --from=build /build/config.ru .
COPY --from=install /usr/local/bundle /usr/local/bundle

CMD ["unicorn"]