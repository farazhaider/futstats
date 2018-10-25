FROM elixir:1.7-alpine

EXPOSE 4000
ENV PORT=4000

RUN apk update && apk add bash

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Cache elixir deps
ADD mix.* ./
RUN mix do deps.get, deps.compile

ADD . .

# Compile the entire project
RUN mix compile

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

CMD ["mix", "phx.server"]


