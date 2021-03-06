defmodule StuytownRents.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stuytown_rents,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {StuytownRents.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:absinthe_ecto, "~> 0.1"},
      {:absinthe_plug, "~> 1.4"},
      {:cowboy, "~> 2.1"},
      {:ecto, "~> 2.0"},
      {:floki, "~> 0.19.0"},
      {:httpoison, "~> 0.13"},
      {:plug, "1.5.0-rc.0", override: true},
      {:poison, "~> 3.0.0"},
      {:postgrex, "~> 0.11"},
      {:private, "> 0.0.0"},
      {:quantum, ">= 2.2.1"},
      {:timex, "~> 3.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
