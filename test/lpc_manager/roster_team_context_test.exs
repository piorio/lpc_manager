defmodule LpcManager.RosterTeamContextTest do
  use LpcManager.DataCase

  alias LpcManager.RosterTeamContext

  describe "roster_teams" do
    alias LpcManager.RosterTeamContext.RosterTeam

    @valid_attrs %{
      apothecary: true,
      name: "some name",
      re_roll_cost: 42,
      re_roll_max: 42,
      special_rules: "some special_rules",
      tier: 42
    }
    @update_attrs %{
      apothecary: false,
      name: "some updated name",
      re_roll_cost: 43,
      re_roll_max: 43,
      special_rules: "some updated special_rules",
      tier: 43
    }
    @invalid_attrs %{
      apothecary: nil,
      name: nil,
      re_roll_cost: nil,
      re_roll_max: nil,
      special_rules: nil,
      tier: nil
    }

    def roster_team_fixture(attrs \\ %{}) do
      {:ok, roster_team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RosterTeamContext.create_roster_team()

      roster_team
    end

    test "list_roster_teams/0 returns all roster_teams" do
      roster_team = roster_team_fixture()
      assert RosterTeamContext.list_roster_teams() == [roster_team]
    end

    test "get_roster_team!/1 returns the roster_team with given id" do
      roster_team = roster_team_fixture()
      assert RosterTeamContext.get_roster_team!(roster_team.id) == roster_team
    end

    test "create_roster_team/1 with valid data creates a roster_team" do
      assert {:ok, %RosterTeam{} = roster_team} =
               RosterTeamContext.create_roster_team(@valid_attrs)

      assert roster_team.apothecary == true
      assert roster_team.name == "some name"
      assert roster_team.re_roll_cost == 42
      assert roster_team.re_roll_max == 42
      assert roster_team.special_rules == "some special_rules"
      assert roster_team.tier == 42
    end

    test "create_roster_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RosterTeamContext.create_roster_team(@invalid_attrs)
    end

    test "update_roster_team/2 with valid data updates the roster_team" do
      roster_team = roster_team_fixture()

      assert {:ok, %RosterTeam{} = roster_team} =
               RosterTeamContext.update_roster_team(roster_team, @update_attrs)

      assert roster_team.apothecary == false
      assert roster_team.name == "some updated name"
      assert roster_team.re_roll_cost == 43
      assert roster_team.re_roll_max == 43
      assert roster_team.special_rules == "some updated special_rules"
      assert roster_team.tier == 43
    end

    test "update_roster_team/2 with invalid data returns error changeset" do
      roster_team = roster_team_fixture()

      assert {:error, %Ecto.Changeset{}} =
               RosterTeamContext.update_roster_team(roster_team, @invalid_attrs)

      assert roster_team == RosterTeamContext.get_roster_team!(roster_team.id)
    end

    test "delete_roster_team/1 deletes the roster_team" do
      roster_team = roster_team_fixture()
      assert {:ok, %RosterTeam{}} = RosterTeamContext.delete_roster_team(roster_team)

      assert_raise Ecto.NoResultsError, fn ->
        RosterTeamContext.get_roster_team!(roster_team.id)
      end
    end

    test "change_roster_team/1 returns a roster_team changeset" do
      roster_team = roster_team_fixture()
      assert %Ecto.Changeset{} = RosterTeamContext.change_roster_team(roster_team)
    end
  end
end
