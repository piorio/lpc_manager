defmodule LpcManager.PlayerContext.RosterPlayerTrait do
  use Ecto.Schema
  import Ecto.Changeset

  @already_exists "ALREADY_EXISTS"

  @primary_key false
  schema "roster_players_traits" do
    belongs_to :roster_player, LpcManager.PlayerContext.RosterPlayer, primary_key: true
    belongs_to :trait, LpcManager.PlayerContext.Trait, primary_key: true
  end

  @doc false
  def changeset(roster_player_trait, attrs) do
    roster_player_trait
    |> cast(attrs, [:roster_player_id, :trait_id])
    |> validate_required([:roster_player_id, :trait_id])
    |> foreign_key_constraint(:roster_player_id)
    |> foreign_key_constraint(:trait_id)
    |> unique_constraint([:roster_player, :trait],
      name: :roster_player_id_trait_id_unique_index,
      message: @already_exists
    )
  end
end
