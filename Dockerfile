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

# This is needed for boot2docker. See: https://github.com/boot2docker/boot2docker/issues/581
#RUN usermod -u 1000 slate
#RUN usermod -G staff slate