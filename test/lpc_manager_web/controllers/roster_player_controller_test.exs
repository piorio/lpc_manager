defmodule LpcManagerWeb.RosterPlayerControllerTest do
  use LpcManagerWeb.ConnCase

  alias LpcManager.RosterPlayerContext

  @create_attrs %{agility: 42, armour_valuev: 42, cost: 42, max_quantity: 42, min_quantity: 42, movement_allowance: 42, passing: 42, position: "some position", primary: [], secondary: [], strength: 42}
  @update_attrs %{agility: 43, armour_valuev: 43, cost: 43, max_quantity: 43, min_quantity: 43, movement_allowance: 43, passing: 43, position: "some updated position", primary: [], secondary: [], strength: 43}
  @invalid_attrs %{agility: nil, armour_valuev: nil, cost: nil, max_quantity: nil, min_quantity: nil, movement_allowance: nil, passing: nil, position: nil, primary: nil, secondary: nil, strength: nil}

  def fixture(:roster_player) do
    {:ok, roster_player} = RosterPlayerContext.create_roster_player(@create_attrs)
    roster_player
  end

  describe "index" do
    test "lists all roster_players", %{conn: conn} do
      conn = get(conn, Routes.roster_player_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Roster players"
    end
  end

  describe "new roster_player" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.roster_player_path(conn, :new))
      assert html_response(conn, 200) =~ "New Roster player"
    end
  end

  describe "create roster_player" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.roster_player_path(conn, :create), roster_player: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.roster_player_path(conn, :show, id)

      conn = get(conn, Routes.roster_player_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Roster player"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.roster_player_path(conn, :create), roster_player: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Roster player"
    end
  end

  describe "edit roster_player" do
    setup [:create_roster_player]

    test "renders form for editing chosen roster_player", %{conn: conn, roster_player: roster_player} do
      conn = get(conn, Routes.roster_player_path(conn, :edit, roster_player))
      assert html_response(conn, 200) =~ "Edit Roster player"
    end
  end

  describe "update roster_player" do
    setup [:create_roster_player]

    test "redirects when data is valid", %{conn: conn, roster_player: roster_player} do
      conn = put(conn, Routes.roster_player_path(conn, :update, roster_player), roster_player: @update_attrs)
      assert redirected_to(conn) == Routes.roster_player_path(conn, :show, roster_player)

      conn = get(conn, Routes.roster_player_path(conn, :show, roster_player))
      assert html_response(conn, 200) =~ "some updated position"
    end

    test "renders errors when data is invalid", %{conn: conn, roster_player: roster_player} do
      conn = put(conn, Routes.roster_player_path(conn, :update, roster_player), roster_player: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Roster player"
    end
  end

  describe "delete roster_player" do
    setup [:create_roster_player]

    test "deletes chosen roster_player", %{conn: conn, roster_player: roster_player} do
      conn = delete(conn, Routes.roster_player_path(conn, :delete, roster_player))
      assert redirected_to(conn) == Routes.roster_player_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.roster_player_path(conn, :show, roster_player))
      end
    end
  end

  defp create_roster_player(_) do
    roster_player = fixture(:roster_player)
    %{roster_player: roster_player}
  end
end
