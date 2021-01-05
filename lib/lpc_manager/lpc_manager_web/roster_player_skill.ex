defmodule LpcManager.LpcManagerWeb.RosterPlayerSkill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roster_players_skills" do
    field :roster_player_id, :id
    field :skill_id, :id

    timestamps()
  end

  @doc false
  def changeset(roster_player_skill, attrs) do
    roster_player_skill
    |> cast(attrs, [])
    |> validate_required([])
  end
end
