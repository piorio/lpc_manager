defmodule LpcManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string

      # Custom fields
      add :coach_name, :string, null: false
      add :role, :string, null: false, default: "user"

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
