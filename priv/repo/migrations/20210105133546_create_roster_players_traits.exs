defmodule LpcManager.Repo.Migrations.CreateRosterPlayersTraits do
  use Ecto.Migration

  def change do
    create table(:roster_players_traits, primary_key: false) do
      add :roster_player_id, references(:roster_players, on_delete: :nothing), primary_key: true
      add :trait_id, references(:traits, on_delete: :nothing), primary_key: true
    end

    create index(:roster_players_traits, [:roster_player_id])
    create index(:roster_players_traits, [:trait_id])
  end
end
