defmodule LpcManager.SkillRules.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skills" do
    field :category, :string
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:name, :category, :description])
    |> validate_required([:name, :category])
    |> unique_constraint(:name)
    |> validate_inclusion(:category, ~w(AGILITY GENERAL MUTATIONS PASSING STRENGTH))
  end
end
