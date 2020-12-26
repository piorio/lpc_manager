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
    |> validate_required([:name, :category, :description])
    |> unique_constraint(:name)
  end
end
