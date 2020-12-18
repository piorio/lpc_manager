defmodule LpcManagerWeb.RaceController do
  use LpcManagerWeb, :controller

  alias LpcManager.Rules
  alias LpcManager.Rules.Race

  def index(conn, _params) do
    races = Rules.list_races()
    render(conn, "index.html", races: races)
  end

  def new(conn, _params) do
    changeset = Rules.change_race(%Race{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"race" => race_params}) do
    case Rules.create_race(race_params) do
      {:ok, race} ->
        conn
        |> put_flash(:info, "Race created successfully.")
        |> redirect(to: Routes.race_path(conn, :show, race))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    race = Rules.get_race!(id)
    render(conn, "show.html", race: race)
  end

  def edit(conn, %{"id" => id}) do
    race = Rules.get_race!(id)
    changeset = Rules.change_race(race)
    render(conn, "edit.html", race: race, changeset: changeset)
  end

  def update(conn, %{"id" => id, "race" => race_params}) do
    race = Rules.get_race!(id)

    case Rules.update_race(race, race_params) do
      {:ok, race} ->
        conn
        |> put_flash(:info, "Race updated successfully.")
        |> redirect(to: Routes.race_path(conn, :show, race))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", race: race, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    race = Rules.get_race!(id)
    {:ok, _race} = Rules.delete_race(race)

    conn
    |> put_flash(:info, "Race deleted successfully.")
    |> redirect(to: Routes.race_path(conn, :index))
  end
end
