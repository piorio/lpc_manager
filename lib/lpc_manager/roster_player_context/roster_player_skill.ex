defmodule LpcManager.RosterPlayerContext.RosterPlayerSkill do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "roster_players_skills" do
    field :roster_player_id, :id, primary_key: true
    field :skill_id, :id, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(roster_player_skill, attrs) do
    roster_player_skill
    |> cast(attrs, [])
    |> validate_required([])
  end
end
