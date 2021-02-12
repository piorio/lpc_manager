defmodule LpcManager.Repo.Migrations.AddRosterTeamReferenceToRosterPlayer do
  use Ecto.Migration

  def change do
    alter table(:roster_players) do
      add :roster_teams_id, references(:roster_teams, on_delete: :nothing)
    end
  end
end
