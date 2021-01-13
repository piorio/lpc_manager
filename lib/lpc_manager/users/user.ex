defmodule LpcManager.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :coach_name, :string
    field :role, :string, null: false, default: "user"

    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:coach_name])
    |> Ecto.Changeset.validate_required([:coach_name])
    |> Ecto.Changeset.unique_constraint(:coach_name)
  end

  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(user admin))
  end
end
