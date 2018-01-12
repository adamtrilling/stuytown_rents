defmodule StuytownRents.Schema do
  use Absinthe.Schema
  import_types StuytownRents.Schema.Types
  import_types Absinthe.Type.Custom

  query do
    field :buildings, list_of(:building) do
      resolve &StuytownRents.Resolvers.BuildingResolver.all/2
    end

    field :units, list_of(:unit) do
      resolve &StuytownRents.Resolvers.UnitResolver.all/2
    end

    field :listings, list_of(:listing) do
      arg :max_price, :integer
      arg :min_price, :integer
      resolve &StuytownRents.Resolvers.ListingResolver.find/2
    end
  end
end