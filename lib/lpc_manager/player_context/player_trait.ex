defmodule LpcManager.PlayerContext.PlayerTrait do
  use Ecto.Schema
  import Ecto.Changeset

  @already_exists "ALREADY_EXISTS"

  @primary_key false
  schema "players_traits" do
    belongs_to :player, LpcManager.PlayerContext.Player, primary_key: true
    belongs_to :trait, LpcManager.PlayerContext.Trait, primary_key: true
  end

  @doc false
  def changeset(player_trait, attrs) do
    player_trait
    |> cast(attrs, [:player_id, :trait_id])
    |> validate_required([:player_id, :trait_id])
    |> foreign_key_constraint(:player_id)
    |> foreign_key_constraint(:trait_id)
    |> unique_constraint([:player, :trait],
      name: :player_id_trait_id_unique_index,
      message: @already_exists
    )
  end
end
