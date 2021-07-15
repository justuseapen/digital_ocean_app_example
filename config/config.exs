# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :digital_ocean_app_example,
  ecto_repos: [DigitalOceanAppExample.Repo]

# Configures the endpoint
config :digital_ocean_app_example, DigitalOceanAppExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Gn+6XfEgQvvAzEDxDRKjnqeSwviTmgv7HTTfzy1GcGF3afS3FSbopS7sU384o70E",
  render_errors: [view: DigitalOceanAppExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DigitalOceanAppExample.PubSub,
  live_view: [signing_salt: "ScnbHWfu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
