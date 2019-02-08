FROM travisci/travis-build:latest

WORKDIR /
USER root

RUN mkdir -p /usr/share/man/man1 \
    && apt-get update -y \
    && apt-get install -y \
      git openjdk-8-jdk-headless openjdk-8-jdk build-essential graphviz \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -r /var/lib/apt/lists/*

RUN git clone https://github.com/travis-ci/travis-build \
    && cd travis-build \
    && mkdir -p ~/.travis \
    && ln -s $PWD ~/.travis/travis-build \
    && gem install bundler \
    && bundle install --gemfile ~/.travis/travis-build/Gemfile \
    && bundler binstubs travis
