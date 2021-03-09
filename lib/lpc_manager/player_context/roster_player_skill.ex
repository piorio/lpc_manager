defmodule LpcManager.PlayerContext.RosterPlayerSkill do
  use Ecto.Schema
  import Ecto.Changeset

  @already_exists "ALREADY_EXISTS"

  @primary_key false
  schema "roster_players_skills" do
    belongs_to :roster_player, LpcManager.PlayerContext.RosterPlayer, primary_key: true
    belongs_to :skill, LpcManager.PlayerContext.Skill, primary_key: true
  end

  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:roster_player_id, :skill_id])
    |> validate_required([:roster_player_id, :skill_id])
    |> foreign_key_constraint(:roster_player_id)
    |> foreign_key_constraint(:skill_id)
    |> unique_constraint([:roster_player, :skill],
      name: :roster_player_id_skill_id_unique_index,
      message: @already_exists
    )
  end
end
