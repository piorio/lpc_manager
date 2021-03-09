defmodule LpcManager.RaceContext.Race do
  use Ecto.Schema
  import Ecto.Changeset

  schema "races" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(race, attrs) do
    race
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
