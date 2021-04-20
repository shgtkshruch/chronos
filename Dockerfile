ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-buster

ARG BUNDLER_VERSION
ARG NODE_MAJOR
ARG YARN_VERSION

# ソースリストにNodeJSを追加
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# ソースリストにYarnを追加
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends\
    build-essential\
    nodejs\
    yarn=$YARN_VERSION-1 &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    truncate -s 0 /var/log/*log

# bundlerとPATHを設定
ENV LANG=C.UTF-8\
  GEM_HOME=/bundle\
  BUNDLE_JOBS=4\
  BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH\
  BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

RUN gem update --system &&\
    gem install bundler:$BUNDLER_VERSION

WORKDIR /app
