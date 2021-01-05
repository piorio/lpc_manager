defmodule LpcManager.LpcManagerWeb.RosterPlayerTrait do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roster_players_traits" do
    field :roster_player_id, :id
    field :trait_id, :id

    timestamps()
  end

  @doc false
  def changeset(roster_player_trait, attrs) do
    roster_player_trait
    |> cast(attrs, [])
    |> validate_required([])
  end
end
