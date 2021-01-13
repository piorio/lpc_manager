defmodule LpcManager.Repo.Migrations.CreateRosterPlayers do
  use Ecto.Migration

  def change do
    create table(:roster_players) do
      add :min_quantity, :integer
      add :max_quantity, :integer
      add :position, :string
      add :cost, :integer
      add :movement_allowance, :integer
      add :strength, :integer
      add :agility, :integer
      add :passing, :integer
      add :armour_value, :integer
      add :primary, {:array, :string}
      add :secondary, {:array, :string}

      timestamps()
    end
  end
end
