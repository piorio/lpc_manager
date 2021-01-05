defmodule LpcManager.RosterPlayerContextTest do
  use LpcManager.DataCase

  alias LpcManager.RosterPlayerContext

  describe "roster_players" do
    alias LpcManager.RosterPlayerContext.RosterPlayer

    @valid_attrs %{agility: 42, armour_valuev: 42, cost: 42, max_quantity: 42, min_quantity: 42, movement_allowance: 42, passing: 42, position: "some position", primary: [], secondary: [], strength: 42}
    @update_attrs %{agility: 43, armour_valuev: 43, cost: 43, max_quantity: 43, min_quantity: 43, movement_allowance: 43, passing: 43, position: "some updated position", primary: [], secondary: [], strength: 43}
    @invalid_attrs %{agility: nil, armour_valuev: nil, cost: nil, max_quantity: nil, min_quantity: nil, movement_allowance: nil, passing: nil, position: nil, primary: nil, secondary: nil, strength: nil}

    def roster_player_fixture(attrs \\ %{}) do
      {:ok, roster_player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RosterPlayerContext.create_roster_player()

      roster_player
    end

    test "list_roster_players/0 returns all roster_players" do
      roster_player = roster_player_fixture()
      assert RosterPlayerContext.list_roster_players() == [roster_player]
    end

    test "get_roster_player!/1 returns the roster_player with given id" do
      roster_player = roster_player_fixture()
      assert RosterPlayerContext.get_roster_player!(roster_player.id) == roster_player
    end

    test "create_roster_player/1 with valid data creates a roster_player" do
      assert {:ok, %RosterPlayer{} = roster_player} = RosterPlayerContext.create_roster_player(@valid_attrs)
      assert roster_player.agility == 42
      assert roster_player.armour_valuev == 42
      assert roster_player.cost == 42
      assert roster_player.max_quantity == 42
      assert roster_player.min_quantity == 42
      assert roster_player.movement_allowance == 42
      assert roster_player.passing == 42
      assert roster_player.position == "some position"
      assert roster_player.primary == []
      assert roster_player.secondary == []
      assert roster_player.strength == 42
    end

    test "create_roster_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RosterPlayerContext.create_roster_player(@invalid_attrs)
    end

    test "update_roster_player/2 with valid data updates the roster_player" do
      roster_player = roster_player_fixture()
      assert {:ok, %RosterPlayer{} = roster_player} = RosterPlayerContext.update_roster_player(roster_player, @update_attrs)
      assert roster_player.agility == 43
      assert roster_player.armour_valuev == 43
      assert roster_player.cost == 43
      assert roster_player.max_quantity == 43
      assert roster_player.min_quantity == 43
      assert roster_player.movement_allowance == 43
      assert roster_player.passing == 43
      assert roster_player.position == "some updated position"
      assert roster_player.primary == []
      assert roster_player.secondary == []
      assert roster_player.strength == 43
    end

    test "update_roster_player/2 with invalid data returns error changeset" do
      roster_player = roster_player_fixture()
      assert {:error, %Ecto.Changeset{}} = RosterPlayerContext.update_roster_player(roster_player, @invalid_attrs)
      assert roster_player == RosterPlayerContext.get_roster_player!(roster_player.id)
    end

    test "delete_roster_player/1 deletes the roster_player" do
      roster_player = roster_player_fixture()
      assert {:ok, %RosterPlayer{}} = RosterPlayerContext.delete_roster_player(roster_player)
      assert_raise Ecto.NoResultsError, fn -> RosterPlayerContext.get_roster_player!(roster_player.id) end
    end

    test "change_roster_player/1 returns a roster_player changeset" do
      roster_player = roster_player_fixture()
      assert %Ecto.Changeset{} = RosterPlayerContext.change_roster_player(roster_player)
    end
  end
end
