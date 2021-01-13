defmodule LpcManager.RosterPlayerContext do
  @moduledoc """
  The RosterPlayerContext context.
  """

  import Ecto.Query, warn: false
  alias LpcManager.Repo

  alias LpcManager.RosterPlayerContext.RosterPlayer
  alias LpcManager.SkillRules
  alias LpcManager.TraitRules

  @doc """
  Returns the list of roster_players.

  ## Examples

      iex> list_roster_players()
      [%RosterPlayer{}, ...]

  """
  def list_roster_players do
    Repo.all(RosterPlayer)
  end

  @doc """
  Gets a single roster_player.

  Raises `Ecto.NoResultsError` if the Roster player does not exist.

  ## Examples

      iex> get_roster_player!(123)
      %RosterPlayer{}

      iex> get_roster_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roster_player!(id), do: Repo.get!(RosterPlayer, id)

  def get_roster_player_with_assoc!(id) do
    RosterPlayer
    |> preload([:traits, :skills])
    |> Repo.get!(id)
  end

  @doc """
  Creates a roster_player.

  ## Examples

      iex> create_roster_player(%{field: value})
      {:ok, %RosterPlayer{}}

      iex> create_roster_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roster_player(attrs \\ %{}) do
    skills = SkillRules.list_skills(attrs["skills"])
    traits = TraitRules.list_traits(attrs["traits"])
    IO.inspect(attrs)
    IO.puts("Create roster player with skills and traits")
    IO.inspect(skills)
    IO.inspect(traits)
    IO.puts("END Create roster player with skills and traits")

    player = %RosterPlayer{}
    |> RosterPlayer.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:skills, skills)
    |> Ecto.Changeset.put_assoc(:traits, traits)
    |> Repo.insert()

    IO.puts("Created player: ")
    IO.inspect(player)
    player
  end

  @doc """
  Updates a roster_player.

  ## Examples

      iex> update_roster_player(roster_player, %{field: new_value})
      {:ok, %RosterPlayer{}}

      iex> update_roster_player(roster_player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roster_player(%RosterPlayer{} = roster_player, attrs) do
    roster_player
    |> RosterPlayer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a roster_player.

  ## Examples

      iex> delete_roster_player(roster_player)
      {:ok, %RosterPlayer{}}

      iex> delete_roster_player(roster_player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roster_player(%RosterPlayer{} = roster_player) do
    Repo.delete(roster_player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roster_player changes.

  ## Examples

      iex> change_roster_player(roster_player)
      %Ecto.Changeset{data: %RosterPlayer{}}

  """
  def change_roster_player(%RosterPlayer{} = roster_player, attrs \\ %{}) do
    RosterPlayer.changeset(roster_player, attrs)
  end
end
