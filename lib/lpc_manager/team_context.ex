defmodule LpcManager.TeamContext do
  @moduledoc """
  The TeamContext context.
  """

  import Ecto.Query, warn: false
  alias LpcManager.Repo

  alias LpcManager.TeamContext.Team
  alias LpcManager.TeamContext.RosterTeam
  alias LpcManager.RaceContext

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  def list_teams_with_assoc do
    Repo.all(Team)
    |> Repo.preload(:user)
    |> Repo.preload(:roster_team)
  end

  def list_users_teams_with_assoc(user) do
    query = from(t in Team, where: t.user_id == ^user.id, preload: [:user, :roster_team])
    Repo.all(query)
  end

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
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  def get_team_with_assoc!(id) do
    Repo.get!(Team, id)
    |> Repo.preload(:user)
    |> Repo.preload(:roster_team)
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
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(conn, attrs \\ %{}) do
    roster_team = get_roster_team!(attrs["roster_team_id"])

    %Team{value: 0, user: Pow.Plug.current_user(conn), roster_team: roster_team}
    |> Team.changeset(attrs)
    |> Repo.insert()
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
    race = RaceContext.get_race!(attrs["race_id"])

    roster_team =
      %RosterTeam{}
      |> RosterTeam.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:race, race)
      |> Repo.insert()

    roster_team
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
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
    race = RaceContext.get_race!(attrs["race_id"])

    roster_team = %RosterTeam{roster_team | race_id: attrs["race_id"]}

    roster_team
    |> Repo.preload(:race)
    |> RosterTeam.changeset(attrs)
    # Required????
    |> Ecto.Changeset.put_assoc(:race, race)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
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
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
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
