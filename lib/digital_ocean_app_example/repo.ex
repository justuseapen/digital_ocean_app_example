defmodule DigitalOceanAppExample.Repo do
  use Ecto.Repo,
    otp_app: :digital_ocean_app_example,
    adapter: Ecto.Adapters.Postgres
end
