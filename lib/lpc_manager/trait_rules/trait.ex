defmodule LpcManager.TraitRules.Trait do
  use Ecto.Schema
  import Ecto.Changeset

  schema "traits" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(trait, attrs) do
    trait
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
