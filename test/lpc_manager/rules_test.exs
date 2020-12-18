defmodule LpcManager.RulesTest do
  use LpcManager.DataCase

  alias LpcManager.Rules

  describe "races" do
    alias LpcManager.Rules.Race

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def race_fixture(attrs \\ %{}) do
      {:ok, race} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rules.create_race()

      race
    end

    test "list_races/0 returns all races" do
      race = race_fixture()
      assert Rules.list_races() == [race]
    end

    test "get_race!/1 returns the race with given id" do
      race = race_fixture()
      assert Rules.get_race!(race.id) == race
    end

    test "create_race/1 with valid data creates a race" do
      assert {:ok, %Race{} = race} = Rules.create_race(@valid_attrs)
      assert race.name == "some name"
    end

    test "create_race/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rules.create_race(@invalid_attrs)
    end

    test "update_race/2 with valid data updates the race" do
      race = race_fixture()
      assert {:ok, %Race{} = race} = Rules.update_race(race, @update_attrs)
      assert race.name == "some updated name"
    end

    test "update_race/2 with invalid data returns error changeset" do
      race = race_fixture()
      assert {:error, %Ecto.Changeset{}} = Rules.update_race(race, @invalid_attrs)
      assert race == Rules.get_race!(race.id)
    end

    test "delete_race/1 deletes the race" do
      race = race_fixture()
      assert {:ok, %Race{}} = Rules.delete_race(race)
      assert_raise Ecto.NoResultsError, fn -> Rules.get_race!(race.id) end
    end

    test "change_race/1 returns a race changeset" do
      race = race_fixture()
      assert %Ecto.Changeset{} = Rules.change_race(race)
    end
  end
end
