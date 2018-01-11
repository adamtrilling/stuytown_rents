defmodule StuytownRents.Schema do
  use Absinthe.Schema

  object :building do
    @desc "A building within the complex"

    field :address, :string
    field :property, :string
  end

  query do
    field :buildings, list_of(:building) do
      resolve &StuytownRents.Resolvers.BuildingResolver.all/2
    end
  end
end