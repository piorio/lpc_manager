defmodule LpcManager.RosterTeamContext.RosterTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roster_teams" do
    field :apothecary, :boolean, default: false
    field :name, :string
    field :re_roll_cost, :integer
    field :re_roll_max, :integer
    field :special_rules, :string
    field :tier, :integer

    belongs_to :race, LpcManager.Rules.Race, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(roster_team, attrs) do
    roster_team
    |> cast(attrs, [:name, :tier, :re_roll_max, :re_roll_cost, :apothecary, :special_rules])
    |> validate_required([:name, :tier, :re_roll_max, :re_roll_cost, :apothecary, :special_rules])
  end
end
