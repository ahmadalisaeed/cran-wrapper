FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /cran_wrapper
RUN mkdir -p /cran_wrapper/data/packages

ENV PACKAGES_DIR /cran_wrapper/data/packages

WORKDIR /cran_wrapper

ARG RAILS_ENV
ARG DATABASE_URL
ARG REDIS_URL


COPY Gemfile /cran_wrapper/Gemfile
COPY Gemfile.lock /cran_wrapper/Gemfile.lock
RUN bundle install
COPY . /cran_wrapper

# Add a script to be executed every time the container starts.
VOLUME ["/app/public"]

RUN chmod -v +x /cran_wrapper/scripts/* \
    && mv -v /cran_wrapper/scripts/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]