use Mix.Config

config :stuytown_rents, StuytownRents.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "stuytown_rents_test",
  username: "stuytown_rents",
  password: "pass",
  hostname: "localhost"