defmodule StuytownRents.Resolvers.UnitResolver do
  alias StuytownRents.Repo
  alias StuytownRents.Models.Unit

  def all(_args, _info) do
    {:ok, Repo.all(Unit)}
  end
end