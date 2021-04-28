defmodule LpcManager.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :hiring_fee, :integer
      add :current_value, :integer
      add :movement_allowance, :integer
      add :strength, :integer
      add :agility, :integer
      add :passing, :integer
      add :armour_value, :integer
      add :name, :string
      add :number, :integer
      add :unspent_spp, :integer
      add :total_spp, :integer
      add :missing_next_game, :boolean, default: false, null: false
      add :injury, :integer
      add :temp_retiring, :boolean, default: false, null: false
      add :roster_player_id, references(:roster_players, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:players, [:roster_player_id])
    create index(:players, [:team_id])
  end
end
