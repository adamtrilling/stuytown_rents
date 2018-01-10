defmodule StuytownRents.Repo.Migrations.CreateListings do
  use Ecto.Migration

  def change do
    create table(:buildings) do
      add :code, :string
      add :address, :string
      add :property, :string
    end

    create unique_index(:buildings, [:code])
    create index(:buildings, [:property])

    create table(:units) do
      add :building_id, references(:buildings)
      add :floor, :string
      add :line, :string
      add :size, :integer
      add :bedrooms, :float
      add :flex, :boolean
      add :trim, :string
    end

    create index(:units, [:bedrooms])
    create index(:units, [:bedrooms, :flex])
    create index(:units, [:trim])

    create table(:listings) do
      add :unit_id, references(:listings)
      add :price, :integer
      add :date, :naive_datetime, default: fragment("now()")
    end

    create index(:listings, [:price])
    create index(:listings, [:date])
  end
end
