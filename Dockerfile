ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}

ARG GID
ARG GID_NAME
ARG UID
ARG UID_NAME
RUN addgroup --gid ${GID} ${GID_NAME} \
    && adduser --uid ${UID} --ingroup ${GID_NAME} --home /home/${UID_NAME} --shell /bin/bash --disabled-password --gecos "" ${UID_NAME}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    && gem update --system \
    && gem install compass rubygems-update \
    && update_rubygems

WORKDIR /home/${UID_NAME}/_data

USER ${UID_NAME}
