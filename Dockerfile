FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -yq ruby ruby-dev build-essential git
RUN gem install --no-ri --no-rdoc bundler

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN cd /app; bundle install

EXPOSE 4567

#ADD . /app
VOLUME /app

WORKDIR /app
CMD ["bundle", "exec", "middleman", "server"]
