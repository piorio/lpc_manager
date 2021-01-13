defmodule LpcManagerWeb.TraitControllerTest do
  use LpcManagerWeb.ConnCase

  alias LpcManager.TraitRules

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:trait) do
    {:ok, trait} = TraitRules.create_trait(@create_attrs)
    trait
  end

  describe "index" do
    test "lists all traits", %{conn: conn} do
      conn = get(conn, Routes.trait_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Traits"
    end
  end

  describe "new trait" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.trait_path(conn, :new))
      assert html_response(conn, 200) =~ "New Trait"
    end
  end

  describe "create trait" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trait_path(conn, :create), trait: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.trait_path(conn, :show, id)

      conn = get(conn, Routes.trait_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Trait"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trait_path(conn, :create), trait: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Trait"
    end
  end

  describe "edit trait" do
    setup [:create_trait]

    test "renders form for editing chosen trait", %{conn: conn, trait: trait} do
      conn = get(conn, Routes.trait_path(conn, :edit, trait))
      assert html_response(conn, 200) =~ "Edit Trait"
    end
  end

  describe "update trait" do
    setup [:create_trait]

    test "redirects when data is valid", %{conn: conn, trait: trait} do
      conn = put(conn, Routes.trait_path(conn, :update, trait), trait: @update_attrs)
      assert redirected_to(conn) == Routes.trait_path(conn, :show, trait)

      conn = get(conn, Routes.trait_path(conn, :show, trait))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, trait: trait} do
      conn = put(conn, Routes.trait_path(conn, :update, trait), trait: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Trait"
    end
  end

  describe "delete trait" do
    setup [:create_trait]

    test "deletes chosen trait", %{conn: conn, trait: trait} do
      conn = delete(conn, Routes.trait_path(conn, :delete, trait))
      assert redirected_to(conn) == Routes.trait_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.trait_path(conn, :show, trait))
      end
    end
  end

  defp create_trait(_) do
    trait = fixture(:trait)
    %{trait: trait}
  end
end
