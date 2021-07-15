import Config

unless config_env() == :prod do
  Dotenv.load!(".env")
end

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    """

host =
  System.get_env("HOST") ||
    raise """
    environment variable HOST is missing
    """

port = String.to_integer(System.get_env("PORT") || "8080")

db_ssl =
  case config_env() do
    :prod -> true
    _ -> false
  end

config :digital_ocean_app_example, DigitalOceanAppExampleWeb.Endpoint,
  url: [host: host, port: port],
  http: [
    transport_options: [socket_opts: [:inet6]],
    port: port
  ],
  secret_key_base: secret_key_base,
  server: true

config :digital_ocean_app_example, DigitalOceanAppExample.Repo,
  ssl: db_ssl,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
