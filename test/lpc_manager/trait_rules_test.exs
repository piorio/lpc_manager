defmodule LpcManager.TraitRulesTest do
  use LpcManager.DataCase

  alias LpcManager.TraitRules

  describe "traits" do
    alias LpcManager.TraitRules.Trait

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def trait_fixture(attrs \\ %{}) do
      {:ok, trait} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TraitRules.create_trait()

      trait
    end

    test "list_traits/0 returns all traits" do
      trait = trait_fixture()
      assert TraitRules.list_traits() == [trait]
    end

    test "get_trait!/1 returns the trait with given id" do
      trait = trait_fixture()
      assert TraitRules.get_trait!(trait.id) == trait
    end

    test "create_trait/1 with valid data creates a trait" do
      assert {:ok, %Trait{} = trait} = TraitRules.create_trait(@valid_attrs)
      assert trait.description == "some description"
      assert trait.name == "some name"
    end

    test "create_trait/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TraitRules.create_trait(@invalid_attrs)
    end

    test "update_trait/2 with valid data updates the trait" do
      trait = trait_fixture()
      assert {:ok, %Trait{} = trait} = TraitRules.update_trait(trait, @update_attrs)
      assert trait.description == "some updated description"
      assert trait.name == "some updated name"
    end

    test "update_trait/2 with invalid data returns error changeset" do
      trait = trait_fixture()
      assert {:error, %Ecto.Changeset{}} = TraitRules.update_trait(trait, @invalid_attrs)
      assert trait == TraitRules.get_trait!(trait.id)
    end

    test "delete_trait/1 deletes the trait" do
      trait = trait_fixture()
      assert {:ok, %Trait{}} = TraitRules.delete_trait(trait)
      assert_raise Ecto.NoResultsError, fn -> TraitRules.get_trait!(trait.id) end
    end

    test "change_trait/1 returns a trait changeset" do
      trait = trait_fixture()
      assert %Ecto.Changeset{} = TraitRules.change_trait(trait)
    end
  end
end
