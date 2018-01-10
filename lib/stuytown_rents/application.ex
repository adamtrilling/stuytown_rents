defmodule StuytownRents.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: StuytownRents.Worker.start_link(arg)
      # {StuytownRents.Worker, arg},
      StuytownRents.Repo,
      StuytownRents.Scheduler,
      {Plug.Adapters.Cowboy2, scheme: :http, plug: StuytownRents.Router}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StuytownRents.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
