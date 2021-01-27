defmodule LpcManager.Repo.Migrations.CreateRosterTeams do
  use Ecto.Migration

  def change do
    create table(:roster_teams) do
      add :name, :string
      add :tier, :integer
      add :re_roll_max, :integer
      add :re_roll_cost, :integer
      add :apothecary, :boolean, default: false, null: false
      add :special_rules, :text
      add :race_id, references(:races, on_delete: :nothing)

      timestamps()
    end

    create index(:roster_teams, [:race_id])
  end
end
