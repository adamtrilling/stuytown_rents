# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :stuytown_rents, ecto_repos: [StuytownRents.Repo]

config :stuytown_rents, StuytownRents.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "stuytown_rents_dev",
  username: "stuytown_rents",
  password: "pass",
  hostname: "localhost"

config :stuytown_rents, StuytownRents.Scheduler,
  global: true,
  timezone: "America/New_York",
  jobs: [
    {"0 0,12 * * *", {StuytownRents.RentLoader, :fetch_and_load, []}},
  ]

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :stuytown_rents, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:stuytown_rents, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

import_config "#{Mix.env}.exs"
