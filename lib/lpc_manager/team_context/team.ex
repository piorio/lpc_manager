defmodule LpcManager.TeamContext.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :value, :integer
    field :treasury, :integer

    belongs_to :user, LpcManager.Users.User
    belongs_to :roster_team, LpcManager.RosterTeamContext.RosterTeam

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :value, :treasury])
    |> validate_required([:name, :value, :treasury])
  end
end
