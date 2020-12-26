defmodule LpcManager.Repo.Migrations.CreateTraits do
  use Ecto.Migration

  def change do
    create table(:traits) do
      add :name, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:traits, [:name])
  end
end
