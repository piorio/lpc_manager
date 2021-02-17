defmodule LpcManager.RosterTeamContext do
  @moduledoc """
  The RosterTeamContext context.
  """

  import Ecto.Query, warn: false
  alias LpcManager.Repo

  alias LpcManager.RosterTeamContext.RosterTeam

  @doc """
  Returns the list of roster_teams.

  ## Examples

      iex> list_roster_teams()
      [%RosterTeam{}, ...]

  """
  def list_roster_teams do
    Repo.all(RosterTeam)
  end

  @doc """
  Gets a single roster_team.

  Raises `Ecto.NoResultsError` if the Roster team does not exist.

  ## Examples

      iex> get_roster_team!(123)
      %RosterTeam{}

      iex> get_roster_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roster_team!(id), do: Repo.get!(RosterTeam, id)

  def get_roster_team_with_assoc!(id) do
    Repo.get!(RosterTeam, id)
    |> Repo.preload(:race)
  end

  @doc """
  Creates a roster_team.

  ## Examples

      iex> create_roster_team(%{field: value})
      {:ok, %RosterTeam{}}

      iex> create_roster_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roster_team(attrs \\ %{}) do
    # roster_player = LpcManager.RosterPlayerContext.get_roster_player!(attrs["roster_players"])
    # roster_player = LpcManager.RosterPlayerContext.get_roster_player!(1)
    race = LpcManager.Rules.get_race!(attrs["race_id"])

    roster_team = %RosterTeam{}
    |> RosterTeam.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:race, race)
    |> Repo.insert()

    roster_team
  end

  @doc """
  Updates a roster_team.

  ## Examples

      iex> update_roster_team(roster_team, %{field: new_value})
      {:ok, %RosterTeam{}}

      iex> update_roster_team(roster_team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roster_team(%RosterTeam{} = roster_team, attrs) do
    # Verify that race exist
    race = LpcManager.Rules.get_race!(attrs["race_id"])

    roster_team = %RosterTeam{roster_team | race_id: attrs["race_id"]}

    roster_team
    |> Repo.preload(:race)
    |> RosterTeam.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:race, race) # Required????
    |> Repo.update()
  end

  @doc """
  Deletes a roster_team.

  ## Examples

      iex> delete_roster_team(roster_team)
      {:ok, %RosterTeam{}}

      iex> delete_roster_team(roster_team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roster_team(%RosterTeam{} = roster_team) do
    Repo.delete(roster_team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roster_team changes.

  ## Examples

      iex> change_roster_team(roster_team)
      %Ecto.Changeset{data: %RosterTeam{}}

  """
  def change_roster_team(%RosterTeam{} = roster_team, attrs \\ %{}) do
    RosterTeam.changeset(roster_team, attrs)
  end
end
