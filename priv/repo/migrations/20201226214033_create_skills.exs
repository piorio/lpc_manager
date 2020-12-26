defmodule LpcManager.Repo.Migrations.CreateSkills do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :string
      add :category, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:skills, [:name])
  end
end
