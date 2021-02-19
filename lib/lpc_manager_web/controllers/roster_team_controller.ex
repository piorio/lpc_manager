defmodule LpcManagerWeb.RosterTeamController do
  use LpcManagerWeb, :controller

  alias LpcManager.RosterTeamContext
  alias LpcManager.RosterTeamContext.RosterTeam

  def index(conn, _params) do
    roster_teams = RosterTeamContext.list_roster_teams()
    render(conn, "index.html", roster_teams: roster_teams)
  end

  def new(conn, _params) do
    races = LpcManager.Rules.list_races()
    |> Map.new(fn race -> {race.name, race.id} end)

    changeset = RosterTeamContext.change_roster_team(%RosterTeam{})
    render(conn, "new.html", changeset: changeset, races: races)
  end

  def create(conn, %{"roster_team" => roster_team_params}) do
    case RosterTeamContext.create_roster_team(roster_team_params) do
      {:ok, roster_team} ->
        conn
        |> put_flash(:info, "Roster team created successfully.")
        |> redirect(to: Routes.roster_team_path(conn, :show, roster_team))

      {:error, %Ecto.Changeset{} = changeset} ->
        races = LpcManager.Rules.list_races()
        |> Map.new(fn race -> {race.name, race.id} end)

        render(conn, "new.html", changeset: changeset, races: races)
    end
  end

  def show(conn, %{"id" => id}) do
    roster_team = RosterTeamContext.get_roster_team_with_assoc!(id)
    render(conn, "show.html", roster_team: roster_team)
  end

  def edit(conn, %{"id" => id}) do
    roster_team = RosterTeamContext.get_roster_team!(id)

    races = LpcManager.Rules.list_races()
    |> Map.new(fn race -> {race.name, race.id} end)

    changeset = RosterTeamContext.change_roster_team(roster_team)
    render(conn, "edit.html", roster_team: roster_team, changeset: changeset, races: races)
  end

  def update(conn, %{"id" => id, "roster_team" => roster_team_params}) do
    roster_team = RosterTeamContext.get_roster_team!(id)

    case RosterTeamContext.update_roster_team(roster_team, roster_team_params) do
      {:ok, roster_team} ->
        conn
        |> put_flash(:info, "Roster team updated successfully.")
        |> redirect(to: Routes.roster_team_path(conn, :show, roster_team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", roster_team: roster_team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    roster_team = RosterTeamContext.get_roster_team!(id)
    {:ok, _roster_team} = RosterTeamContext.delete_roster_team(roster_team)

    conn
    |> put_flash(:info, "Roster team deleted successfully.")
    |> redirect(to: Routes.roster_team_path(conn, :index))
  end
end
