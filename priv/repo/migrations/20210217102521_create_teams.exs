defmodule LpcManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :value, :integer
      add :treasury, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :roster_team_id, references(:roster_teams, on_delete: :nothing)

      timestamps()
    end

    create index(:teams, [:user_id])
    create index(:teams, [:roster_team_id])
    create unique_index(:teams, [:name])
  end
end
