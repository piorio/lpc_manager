defmodule LpcManager.Repo.Migrations.CreateRosterPlayersTraits do
  use Ecto.Migration

  def change do
    create table(:roster_players_traits, primary_key: false) do
      add :roster_player_id, references(:roster_players, on_delete: :delete_all), primary_key: true
      add :trait_id, references(:traits, on_delete: :delete_all), primary_key: true
    end

    create index(:roster_players_traits, [:roster_player_id])
    create index(:roster_players_traits, [:trait_id])

    create(
      unique_index(:roster_players_traits, [:roster_player_id, :trait_id], name: :roster_player_id_trait_id_unique_index)
    )

  end
end
