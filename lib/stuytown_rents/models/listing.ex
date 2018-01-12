defmodule StuytownRents.Models.Listing do
  use Ecto.Schema

  schema "listings" do
    belongs_to :unit, StuytownRents.Models.Unit
    field :price, :integer
    field :date, :naive_datetime
  end
end