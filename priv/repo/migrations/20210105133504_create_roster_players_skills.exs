defmodule LpcManager.Repo.Migrations.CreateRosterPlayersSkills do
  use Ecto.Migration

  def change do
    create table(:roster_players_skills, primary_key: false) do
      add :roster_player_id, references(:roster_players, on_delete: :nothing), primary_key: true
      add :skill_id, references(:skills, on_delete: :nothing), primary_key: true
    end

    create index(:roster_players_skills, [:roster_player_id])
    create index(:roster_players_skills, [:skill_id])
  end
end
