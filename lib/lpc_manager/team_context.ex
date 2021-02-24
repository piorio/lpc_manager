defmodule LpcManager.TeamContext do
  @moduledoc """
  The TeamContext context.
  """

  import Ecto.Query, warn: false
  alias LpcManager.Repo

  alias LpcManager.TeamContext.Team

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
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(conn, attrs \\ %{}) do
    roster_team = LpcManager.RosterTeamContext.get_roster_team!(attrs["roster_team_id"])

    %Team{value: 0, user: Pow.Plug.current_user(conn), roster_team: roster_team}
      |> Team.changeset(attrs)
      |> Repo.insert()
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
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end
end
