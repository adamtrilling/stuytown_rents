defmodule StuytownRents.Resolvers.BuildingResolver do
  alias StuytownRents.Repo
  alias StuytownRents.Models.Building

  def all(_args, _info) do
    {:ok, Repo.all(Building)}
  end
end