defmodule LpcManagerWeb.RosterTeamControllerTest do
  use LpcManagerWeb.ConnCase

  alias LpcManager.RosterTeamContext

  @create_attrs %{apothecary: true, name: "some name", re_roll_cost: 42, re_roll_max: 42, special_rules: "some special_rules", tier: 42}
  @update_attrs %{apothecary: false, name: "some updated name", re_roll_cost: 43, re_roll_max: 43, special_rules: "some updated special_rules", tier: 43}
  @invalid_attrs %{apothecary: nil, name: nil, re_roll_cost: nil, re_roll_max: nil, special_rules: nil, tier: nil}

  def fixture(:roster_team) do
    {:ok, roster_team} = RosterTeamContext.create_roster_team(@create_attrs)
    roster_team
  end

  describe "index" do
    test "lists all roster_teams", %{conn: conn} do
      conn = get(conn, Routes.roster_team_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Roster teams"
    end
  end

  describe "new roster_team" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.roster_team_path(conn, :new))
      assert html_response(conn, 200) =~ "New Roster team"
    end
  end

  describe "create roster_team" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.roster_team_path(conn, :create), roster_team: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.roster_team_path(conn, :show, id)

      conn = get(conn, Routes.roster_team_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Roster team"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.roster_team_path(conn, :create), roster_team: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Roster team"
    end
  end

  describe "edit roster_team" do
    setup [:create_roster_team]

    test "renders form for editing chosen roster_team", %{conn: conn, roster_team: roster_team} do
      conn = get(conn, Routes.roster_team_path(conn, :edit, roster_team))
      assert html_response(conn, 200) =~ "Edit Roster team"
    end
  end

  describe "update roster_team" do
    setup [:create_roster_team]

    test "redirects when data is valid", %{conn: conn, roster_team: roster_team} do
      conn = put(conn, Routes.roster_team_path(conn, :update, roster_team), roster_team: @update_attrs)
      assert redirected_to(conn) == Routes.roster_team_path(conn, :show, roster_team)

      conn = get(conn, Routes.roster_team_path(conn, :show, roster_team))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, roster_team: roster_team} do
      conn = put(conn, Routes.roster_team_path(conn, :update, roster_team), roster_team: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Roster team"
    end
  end

  describe "delete roster_team" do
    setup [:create_roster_team]

    test "deletes chosen roster_team", %{conn: conn, roster_team: roster_team} do
      conn = delete(conn, Routes.roster_team_path(conn, :delete, roster_team))
      assert redirected_to(conn) == Routes.roster_team_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.roster_team_path(conn, :show, roster_team))
      end
    end
  end

  defp create_roster_team(_) do
    roster_team = fixture(:roster_team)
    %{roster_team: roster_team}
  end
end
