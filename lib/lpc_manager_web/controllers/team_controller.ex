defmodule LpcManagerWeb.TeamController do
  use LpcManagerWeb, :controller

  alias LpcManager.TeamContext
  alias LpcManager.TeamContext.Team

  def index(conn, _params) do
    teams = TeamContext.list_teams_with_assoc()
    render(conn, "index.html", teams: teams)
  end

  def index_my_teams(conn, _params) do
    teams =
      Pow.Plug.current_user(conn)
      |> TeamContext.list_users_teams_with_assoc()

    render(conn, "index_my_teams.html", teams: teams)
  end

  def new(conn, _params) do
    roster_teams =
      TeamContext.list_roster_teams()
      |> Map.new(fn team -> {team.name, team.id} end)

    changeset = TeamContext.change_team(%Team{})
    render(conn, "new.html", changeset: changeset, roster_teams: roster_teams)
  end

  def create(conn, %{"team" => team_params}) do
    case TeamContext.create_team(conn, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: Routes.team_path(conn, :show, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = TeamContext.get_team_with_assoc!(id)
    render(conn, "show.html", team: team)
  end

  def edit(conn, %{"id" => id}) do
    # TODO: at the moment I don't know how and who could EDIT a team

    #team = TeamContext.get_team!(id)
    #changeset = TeamContext.change_team(team)

    # Can't pass roster_teams because edit team will never change the roster team
    #render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = TeamContext.get_team!(id)

    case TeamContext.update_team(team, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: Routes.team_path(conn, :show, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = TeamContext.get_team!(id)
    {:ok, _team} = TeamContext.delete_team(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: Routes.team_path(conn, :index))
  end

  def prepare_my_team(conn, %{"id" => id}) do
    team = TeamContext.get_team!(id)
    changeset = TeamContext.change_team(team)
    render(conn, "prepare.html", team: team, changeset: changeset)
  end

  def dismiss_my_team(conn, _params) do
    IO.puts("\n == DISMISS")
    render(conn, "index_my_teams.html")
  end

  def manage_my_team(conn, _params) do
    IO.puts("\n == MANAGE")
    render(conn, "index_my_teams.html")
  end

  def save_prepare(conn, _params) do
    IO.puts("\n == SAVE PREPARE")
    render(conn, "index_my_teams.html")
  end
end
