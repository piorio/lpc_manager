defmodule LpcManager.TeamContextTest do
  use LpcManager.DataCase

  alias LpcManager.TeamContext

  describe "teams" do
    alias LpcManager.TeamContext.Team

    @valid_attrs %{name: "some name", value: 42}
    @update_attrs %{name: "some updated name", value: 43}
    @invalid_attrs %{name: nil, value: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TeamContext.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert TeamContext.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert TeamContext.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = TeamContext.create_team(@valid_attrs)
      assert team.name == "some name"
      assert team.value == 42
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamContext.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = TeamContext.update_team(team, @update_attrs)
      assert team.name == "some updated name"
      assert team.value == 43
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamContext.update_team(team, @invalid_attrs)
      assert team == TeamContext.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = TeamContext.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> TeamContext.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = TeamContext.change_team(team)
    end
  end
end
