defmodule LpcManager.PlayerContext.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :agility, :integer
    field :armour_value, :integer
    field :current_value, :integer
    field :hiring_fee, :integer
    field :injury, :integer
    field :missing_next_game, :boolean, default: false
    field :movement_allowance, :integer
    field :name, :string
    field :number, :integer
    field :passing, :integer
    field :strength, :integer
    field :temp_retiring, :boolean, default: false
    field :total_spp, :integer
    field :unspent_spp, :integer
    field :roster_player_id, :id
    field :team_id, :id

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:hiring_fee, :current_value, :movement_allowance, :strength, :agility, :passing, :armour_value, :name, :number, :unspent_spp, :total_spp, :missing_next_game, :injury, :temp_retiring])
    |> validate_required([:hiring_fee, :current_value, :movement_allowance, :strength, :agility, :passing, :armour_value, :name, :number, :unspent_spp, :total_spp, :missing_next_game, :injury, :temp_retiring])
  end
end
