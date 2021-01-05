defmodule LpcManager.RosterPlayerContext.RosterPlayerTrait do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "roster_players_traits" do
    field :roster_player_id, :id, primary_key: true
    field :trait_id, :id, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(roster_player_trait, attrs) do
    roster_player_trait
    |> cast(attrs, [])
    |> validate_required([])
  end
end
