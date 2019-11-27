defmodule Cookbook.MenuTest do
  use Cookbook.DataCase

  alias Cookbook.Menu
  alias Cookbook.Menu.Meal
  alias Cookbook.Repo

  @valid_attrs %{first_seen: ~D[2010-04-17], img_url: "some img_url", last_seen: ~D[2010-04-17], name: "some name", note: "some note", time: 42}

  describe "meals" do
    test "list_meals/0 returns all meals" do
      meal = %Meal{} |> Meal.changeset(@valid_attrs) |> Repo.insert!()
      assert meal in Menu.list_meals()
    end

    test "get_meal!/1 returns the meal with given id" do
      meal = %Meal{} |> Meal.changeset(@valid_attrs) |> Repo.insert!()
      assert Menu.get_meal!(meal.id) == meal
    end
  end
end
