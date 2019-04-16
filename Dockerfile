FROM ruby:2.6

LABEL maintainer="cgspeck@gmail.com"

RUN apt-get -y update \
  && apt-get -y install \
    cmake \
    libicu-dev \
    sudo \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.0.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY ./Gemfile* /usr/src/app/

RUN bundle install

COPY . .

RUN chmod +x wrapper.rb

ENV TARGET_DIR=/wiki
ENV PUID=1000
ENV PGID=1000

ENV GOLLUM_OPTIONS="--h1-title --allow-uploads --live-preview"
ENV GOLLUM_AUTHOR_USERNAME="Gollum User"
ENV GOLLUM_AUTHOR_EMAIL="gollum@example.org"
EXPOSE 4567

VOLUME $TARGET_DIR

ENTRYPOINT ["./entrypoint.sh"]
