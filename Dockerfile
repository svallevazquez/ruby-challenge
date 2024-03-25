FROM ruby:3.3.0

ENV APP_HOME=/ruby-challenge

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile Gemfile.lock $APP_HOME/
RUN gem install bundler:2.5.7
RUN bundle
RUN bundle exec rspec
