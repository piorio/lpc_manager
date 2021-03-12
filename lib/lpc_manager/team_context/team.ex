defmodule LpcManager.TeamContext.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :value, :integer
    field :treasury, :integer
    field :status, :string
    field :re_roll, :integer
    field :assistant_coach, :integer
    field :cheerleader, :integer
    field :apothecary, :boolean
    field :current_team_value, :integer

    belongs_to :user, LpcManager.Users.User
    belongs_to :roster_team, LpcManager.TeamContext.RosterTeam

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :value, :treasury, :status, :re_roll, :assistant_coach, :cheerleader, :apothecary, :current_team_value])
    |> validate_required([:name, :value, :treasury, :status])
    |> unique_constraint(:name)
    |> validate_inclusion(:status, ~w(CREATED READY DISMISS))
  end
end
