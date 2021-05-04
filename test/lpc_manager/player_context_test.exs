defmodule LpcManager.PlayerContextTest do
  use LpcManager.DataCase

  alias LpcManager.PlayerContext

  describe "players" do
    alias LpcManager.PlayerContext.Player

    @valid_attrs %{
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

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PlayerContext.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert PlayerContext.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert PlayerContext.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = PlayerContext.create_player(@valid_attrs)
      assert player.agility == 42
      assert player.armour_value == 42
      assert player.current_value == 42
      assert player.hiring_fee == 42
      assert player.injury == 42
      assert player.missing_next_game == true
      assert player.movement_allowance == 42
      assert player.name == "some name"
      assert player.number == 42
      assert player.passing == 42
      assert player.strength == 42
      assert player.temp_retiring == true
      assert player.total_spp == 42
      assert player.unspent_spp == 42
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PlayerContext.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, %Player{} = player} = PlayerContext.update_player(player, @update_attrs)
      assert player.agility == 43
      assert player.armour_value == 43
      assert player.current_value == 43
      assert player.hiring_fee == 43
      assert player.injury == 43
      assert player.missing_next_game == false
      assert player.movement_allowance == 43
      assert player.name == "some updated name"
      assert player.number == 43
      assert player.passing == 43
      assert player.strength == 43
      assert player.temp_retiring == false
      assert player.total_spp == 43
      assert player.unspent_spp == 43
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = PlayerContext.update_player(player, @invalid_attrs)
      assert player == PlayerContext.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = PlayerContext.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> PlayerContext.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = PlayerContext.change_player(player)
    end
  end
end
