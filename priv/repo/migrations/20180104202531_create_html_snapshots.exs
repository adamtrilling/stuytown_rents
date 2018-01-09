defmodule StuytownRents.Repo.Migrations.CreateHtmlSnapshots do
  use Ecto.Migration

  def change do
    create table(:html_snapshots) do
      add :html, :text
      add :availability_date, :date
      add :processed, :boolean, default: false
    end

    create index(:html_snapshots, [:processed])
  end
end
