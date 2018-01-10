defmodule StuytownRents.Models.HtmlSnapshot do
    use Ecto.Schema

    schema "html_snapshots" do
        field :html, :string
        field :availability_date, :date
        field :processed, :boolean
    end
end