defmodule LpcManager.Repo.Migrations.CreateRaces do
  use Ecto.Migration

  def change do
    create table(:races) do
      add :name, :string

      timestamps()
    end

    create unique_index(:races, [:name])
  end
end
