defmodule LpcManager.TeamContext.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :value, :integer
    field :treasury, :integer
    field :roster_team, :id

    #field :user, :id
    belongs_to :user, LpcManager.Users.User

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :value, :treasury])
    |> validate_required([:name, :value, :treasury])
  end
end
