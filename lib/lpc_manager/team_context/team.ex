defmodule LpcManager.TeamContext.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :value, :integer
    field :treasury, :integer
    field :user, :id
    field :roster_team, :id

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :value, :treasury])
    |> validate_required([:name, :value, :treasury])
  end
end
