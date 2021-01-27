defmodule LpcManager.RosterPlayerContext.RosterPlayer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roster_players" do
    field :agility, :integer
    field :armour_value, :integer
    field :cost, :integer
    field :max_quantity, :integer
    field :min_quantity, :integer
    field :movement_allowance, :integer
    field :passing, :integer
    field :position, :string
    field :primary, {:array, :string}
    field :secondary, {:array, :string}
    field :strength, :integer

    many_to_many :skills, LpcManager.SkillRules.Skill, join_through: LpcManager.RosterPlayerContext.RosterPlayerSkill, on_replace: :delete

    many_to_many :traits, LpcManager.TraitRules.Trait, join_through: LpcManager.RosterPlayerContext.RosterPlayerTrait, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(roster_player, attrs) do
    roster_player
    |> cast(attrs, [
      :min_quantity,
      :max_quantity,
      :position,
      :cost,
      :movement_allowance,
      :strength,
      :agility,
      :passing,
      :armour_value,
      :primary,
      :secondary
    ])
    |> validate_required([
      :min_quantity,
      :max_quantity,
      :position,
      :cost,
      :movement_allowance,
      :strength,
      :agility,
      :passing,
      :armour_value,
      :primary,
      :secondary
    ])
  end
end
