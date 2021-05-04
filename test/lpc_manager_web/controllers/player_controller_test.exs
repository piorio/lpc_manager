defmodule LpcManagerWeb.PlayerControllerTest do
  use LpcManagerWeb.ConnCase

  alias LpcManager.PlayerContext

  @create_attrs %{
    agility: 42,
    armour_value: 42,
    current_value: 42,
    hiring_fee: 42,
    injury: 42,
    missing_next_game: true,
    movement_allowance: 42,
    name: "some name",
    number: 42,
    passing: 42,
    strength: 42,
    temp_retiring: true,
    total_spp: 42,
    unspent_spp: 42
  }
  @update_attrs %{
    agility: 43,
    armour_value: 43,
    current_value: 43,
    hiring_fee: 43,
    injury: 43,
    missing_next_game: false,
    movement_allowance: 43,
    name: "some updated name",
    number: 43,
    passing: 43,
    strength: 43,
    temp_retiring: false,
    total_spp: 43,
    unspent_spp: 43
  }
  @invalid_attrs %{
    agility: nil,
    armour_value: nil,
    current_value: nil,
    hiring_fee: nil,
    injury: nil,
    missing_next_game: nil,
    movement_allowance: nil,
    name: nil,
    number: nil,
    passing: nil,
    strength: nil,
    temp_retiring: nil,
    total_spp: nil,
    unspent_spp: nil
  }

  def fixture(:player) do
    {:ok, player} = PlayerContext.create_player(@create_attrs)
    player
  end

  describe "index" do
    test "lists all players", %{conn: conn} do
      conn = get(conn, Routes.player_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Players"
    end
  end

  describe "new player" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.player_path(conn, :new))
      assert html_response(conn, 200) =~ "New Player"
    end
  end

  describe "create player" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.player_path(conn, :create), player: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.player_path(conn, :show, id)

      conn = get(conn, Routes.player_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Player"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.player_path(conn, :create), player: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Player"
    end
  end

  describe "edit player" do
    setup [:create_player]

    test "renders form for editing chosen player", %{conn: conn, player: player} do
      conn = get(conn, Routes.player_path(conn, :edit, player))
      assert html_response(conn, 200) =~ "Edit Player"
    end
  end

  describe "update player" do
    setup [:create_player]

    test "redirects when data is valid", %{conn: conn, player: player} do
      conn = put(conn, Routes.player_path(conn, :update, player), player: @update_attrs)
      assert redirected_to(conn) == Routes.player_path(conn, :show, player)

      conn = get(conn, Routes.player_path(conn, :show, player))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, player: player} do
      conn = put(conn, Routes.player_path(conn, :update, player), player: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Player"
    end
  end

  describe "delete player" do
    setup [:create_player]

    test "deletes chosen player", %{conn: conn, player: player} do
      conn = delete(conn, Routes.player_path(conn, :delete, player))
      assert redirected_to(conn) == Routes.player_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.player_path(conn, :show, player))
      end
    end
  end

  defp create_player(_) do
    player = fixture(:player)
    %{player: player}
  end
end
