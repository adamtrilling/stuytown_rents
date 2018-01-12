defmodule StuytownRents.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: StuytownRents.Repo

  object :building do
    @desc "A building within the complex"

    field :address, :string
    field :property, :string
    field :units, list_of(:unit), resolve: assoc(:units)
  end

  object :unit do
    @desc "An apartment within a building"

    field :floor, :string
    field :line, :string
    field :size, :integer
    field :bedrooms, :float
    field :flex, :boolean
    field :trim, :string
    field :building, :building, resolve: assoc(:building)
    field :listings, list_of(:listing), resolve: assoc(:listings)
  end

  object :listing do
    @desc "An available apartment on a particular date"

    field :price, :integer
    field :date, :naive_datetime
    field :unit, :unit, resolve: assoc(:unit)
  end
end