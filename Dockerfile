FROM ruby:2.6.3

LABEL maintainer="Sokly <sokly@instedd.org>"

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update -qq && \
  apt-get install -y nodejs yarn postgresql-client && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler:2.0.2 && \
  bundle install --jobs 20 --deployment --without development test

# Install the application
COPY . /app

# Generate version file if available
RUN if [ -d .git ]; then git describe --always > VERSION; fi

# Precompile assets
RUN bundle exec rake assets:precompile RAILS_ENV=production && \
  rm config/credentials/production.key

ENV RAILS_LOG_TO_STDOUT=true
ENV RACK_ENV=production
ENV RAILS_ENV=production
EXPOSE 80

CMD ["puma", "-e", "production", "-b", "tcp://0.0.0.0:80"]
