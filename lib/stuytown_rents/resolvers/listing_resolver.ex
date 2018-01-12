defmodule StuytownRents.Resolvers.ListingResolver do
  alias StuytownRents.Repo
  alias StuytownRents.Models.Listing
  import Ecto.Query

  def find(args, _info) do
    max_price = Map.get(args, :max_price, 20000)
    min_price = Map.get(args, :min_price, 0)

    query = from l in Listing,
      where: l.price <= ^max_price,
      where: l.price >= ^min_price

    {:ok, query |> Repo.all}
  end
end