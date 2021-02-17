defmodule LpcManagerWeb.RosterPlayerController do
  use LpcManagerWeb, :controller

  alias LpcManager.RosterPlayerContext
  alias LpcManager.RosterPlayerContext.RosterPlayer
  alias LpcManager.SkillRules
  alias LpcManager.TraitRules

  def index(conn, _params) do
    roster_players = RosterPlayerContext.list_roster_players()
    render(conn, "index.html", roster_players: roster_players)
  end

  def new(conn, _params) do
    skills_map =
      SkillRules.list_skills()
      |> Map.new(fn skill -> {skill.name, skill.id} end)

    traits_map =
      TraitRules.list_traits()
      |> Map.new(fn trait -> {trait.name, trait.id} end)

    skills_map = Map.put(skills_map, " ", -1)
    traits_map = Map.put(traits_map, " ", -1)

    roster_teams_list = LpcManager.RosterTeamContext.list_roster_teams()
      |> Map.new(fn team -> {team.name, team.id} end)

    changeset = RosterPlayerContext.change_roster_player(%RosterPlayer{skills: [], traits: []})
    render(conn, "new.html", changeset: changeset, skills: skills_map, traits: traits_map, roster_teams_list: roster_teams_list)
  end

  def create(conn, %{"roster_player" => roster_player_params}) do
    case RosterPlayerContext.create_roster_player(roster_player_params) do
      {:ok, roster_player} ->
        conn
        |> put_flash(:info, "Roster player created successfully.")
        |> redirect(to: Routes.roster_player_path(conn, :show, roster_player))

      {:error, %Ecto.Changeset{} = changeset} ->
        skills_map =
          SkillRules.list_skills()
          |> Map.new(fn skill -> {skill.name, skill.id} end)

        traits_map =
          TraitRules.list_traits()
          |> Map.new(fn trait -> {trait.name, trait.id} end)

        skills_map = Map.put(skills_map, " ", -1)
        traits_map = Map.put(traits_map, " ", -1)

        roster_teams_list = LpcManager.RosterTeamContext.list_roster_teams()
          |> Map.new(fn team -> {team.name, team.id} end)

        changeset = %Ecto.Changeset{changeset | data: %RosterPlayer{skills: [], traits: []}}

        IO.inspect(changeset)

        render(conn, "new.html", changeset: changeset, skills: skills_map, traits: traits_map, roster_teams_list: roster_teams_list)
    end
  end

  def show(conn, %{"id" => id}) do
    roster_player = RosterPlayerContext.get_roster_player_with_assoc!(id)
    render(conn, "show.html", roster_player: roster_player)
  end

  def edit(conn, %{"id" => id}) do
    skills_map =
      SkillRules.list_skills()
      |> Map.new(fn skill -> {skill.name, skill.id} end)

    traits_map =
      TraitRules.list_traits()
      |> Map.new(fn trait -> {trait.name, trait.id} end)

    skills_map = Map.put(skills_map, " ", -1)
    traits_map = Map.put(traits_map, " ", -1)

    roster_teams_list = LpcManager.RosterTeamContext.list_roster_teams()
      |> Map.new(fn team -> {team.name, team.id} end)

    roster_player = RosterPlayerContext.get_roster_player_with_assoc!(id)
    changeset = RosterPlayerContext.change_roster_player(roster_player)

    render(conn, "edit.html",
      roster_player: roster_player,
      changeset: changeset,
      skills: skills_map,
      traits: traits_map,
      roster_teams_list: roster_teams_list
    )
  end

  def update(conn, %{"id" => id, "roster_player" => roster_player_params}) do
    roster_player = RosterPlayerContext.get_roster_player!(id)

    case RosterPlayerContext.update_roster_player(roster_player, roster_player_params) do
      {:ok, roster_player} ->
        conn
        |> put_flash(:info, "Roster player updated successfully.")
        |> redirect(to: Routes.roster_player_path(conn, :show, roster_player))

      {:error, %Ecto.Changeset{} = changeset} ->
        skills_map =
          SkillRules.list_skills()
          |> Map.new(fn skill -> {skill.name, skill.id} end)

        traits_map =
          TraitRules.list_traits()
          |> Map.new(fn trait -> {trait.name, trait.id} end)

        skills_map = Map.put(skills_map, " ", -1)
        traits_map = Map.put(traits_map, " ", -1)

        roster_teams_list = LpcManager.RosterTeamContext.list_roster_teams()
        |> Map.new(fn team -> {team.name, team.id} end)

        render(conn, "edit.html",
          roster_player: roster_player,
          changeset: changeset,
          skills: skills_map,
          traits: traits_map,
          roster_teams_list: roster_teams_list
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    roster_player = RosterPlayerContext.get_roster_player!(id)
    {:ok, _roster_player} = RosterPlayerContext.delete_roster_player(roster_player)

    conn
    |> put_flash(:info, "Roster player deleted successfully.")
    |> redirect(to: Routes.roster_player_path(conn, :index))
  end
end
