defmodule LpcManager.Repo.Migrations.CreatePlayersTraits do
  use Ecto.Migration

  def change do
    create table(:players_traits, primary_key: false) do
      add :player_id, references(:players, on_delete: :delete_all), primary_key: true
      add :trait_id, references(:traits, on_delete: :delete_all), primary_key: true
    end

    create index(:players_traits, [:player_id])
    create index(:players_traits, [:trait_id])

    create(
      unique_index(:players_traits, [:player_id, :trait_id],
        name: :player_id_trait_id_unique_index
      )
    )
  end
end
