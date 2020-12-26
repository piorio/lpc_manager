defmodule LpcManager.SkillRulesTest do
  use LpcManager.DataCase

  alias LpcManager.SkillRules

  describe "skills" do
    alias LpcManager.SkillRules.Skill

    @valid_attrs %{category: "some category", description: "some description", name: "some name"}
    @update_attrs %{category: "some updated category", description: "some updated description", name: "some updated name"}
    @invalid_attrs %{category: nil, description: nil, name: nil}

    def skill_fixture(attrs \\ %{}) do
      {:ok, skill} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SkillRules.create_skill()

      skill
    end

    test "list_skills/0 returns all skills" do
      skill = skill_fixture()
      assert SkillRules.list_skills() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert SkillRules.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      assert {:ok, %Skill{} = skill} = SkillRules.create_skill(@valid_attrs)
      assert skill.category == "some category"
      assert skill.description == "some description"
      assert skill.name == "some name"
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SkillRules.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{} = skill} = SkillRules.update_skill(skill, @update_attrs)
      assert skill.category == "some updated category"
      assert skill.description == "some updated description"
      assert skill.name == "some updated name"
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = SkillRules.update_skill(skill, @invalid_attrs)
      assert skill == SkillRules.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = SkillRules.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> SkillRules.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = SkillRules.change_skill(skill)
    end
  end
end
