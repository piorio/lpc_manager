defmodule LpcManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :value, :integer
      add :treasury, :integer
      add :user, references(:users, on_delete: :nothing)
      add :roster_team, references(:roster_teams, on_delete: :nothing)

      timestamps()
    end

    create index(:teams, [:user])
    create index(:teams, [:roster_team])
  end
end
