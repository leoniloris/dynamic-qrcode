FROM elixir:1.9.1-slim

# basic dependencies to make it all work
RUN apt-get update -qq && apt-get -y --allow-unauthenticated install curl libpq-dev postgresql-client git make erlang-crypto apt-transport-https

# creating a user for the app
ARG UID=1000
RUN useradd -m -u $UID lml
USER lml

RUN mkdir /home/lml/app
WORKDIR /home/lml/app
RUN mkdir -p /home/lml/app/deps; chown -R lml:lml /home/lml/app/deps
VOLUME ["/home/lml/app/deps"]

RUN mix local.hex --force
RUN mix local.rebar --force
