defmodule StuytownRents.Listing do
    use Ecto.Schema

    schema "listings" do
        belongs_to :unit, StuytownRents.Unit
        field :price, :integer
        field :date, :date
    end
end