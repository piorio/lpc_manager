defmodule LpcManager.PlayerContext.PlayerSkill do
  use Ecto.Schema
  import Ecto.Changeset

  @already_exists "ALREADY_EXISTS"

  @primary_key false
  schema "players_skills" do
    belongs_to :player, LpcManager.PlayerContext.Player, primary_key: true
    belongs_to :skill, LpcManager.PlayerContext.Skill, primary_key: true
  end

  @doc false
  def changeset(player_skill, attrs) do
    player_skill
    |> cast(attrs, [:player_id, :skill_id])
    |> validate_required([:player_id, :skill_id])
    |> foreign_key_constraint(:player_id)
    |> foreign_key_constraint(:skill_id)
    |> unique_constraint([:player, :skill],
      name: :player_id_skill_id_unique_index,
      message: @already_exists
    )
  end
end
