defmodule LpcManager.Repo.Migrations.CreatePlayersSkills do
  use Ecto.Migration

  def change do
    create table(:players_skills, primary_key: false) do
      add :player_id, references(:players, on_delete: :delete_all), primary_key: true
      add :skill_id, references(:skills, on_delete: :delete_all), primary_key: true
    end

    create index(:players_skills, [:player_id])
    create index(:players_skills, [:skill_id])

    create(
      unique_index(:players_skills, [:player_id, :skill_id],
        name: :player_id_skill_id_unique_index
      )
    )
  end
end
