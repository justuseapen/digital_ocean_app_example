#########
# BUILD #
#########

FROM elixir:1.12.2-alpine AS build

RUN apk add --no-cache build-base git npm

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

COPY assets/package.json assets/package-lock.json ./assets/
COPY lib/digital_ocean_app_example_web /app/lib/digital_ocean_app_example_web
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

COPY lib lib
# COPY rel rel
RUN mix do compile, release

###########
# RELEASE #
###########

FROM alpine:3.14 AS app

RUN apk add --no-cache openssl libgcc libstdc++ ncurses-libs

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/digital_ocean_app_example ./

ENV HOME=/app

EXPOSE 8080

CMD ["bin/digital_ocean_app_example", "start"]
