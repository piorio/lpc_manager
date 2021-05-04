defmodule LpcManager.Repo.Migrations.AddTeamInfo do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :status, :string
      add :re_roll, :integer
      add :assistant_coach, :integer
      add :cheerleader, :integer
      add :apothecary, :boolean
      add :current_team_value, :integer
    end
  end
end
