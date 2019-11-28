defmodule Cookbook.MenuTest do
  use Cookbook.DataCase

  alias Cookbook.Menu
  import Cookbook.MealFactory

  describe "meals" do
    test "list_meals/1 returns all meals when no params" do
      meal = create_meal()
      assert Menu.list_meals(%{}) == [meal]
    end

    test "list_meals/1 returns only meals matching the search term when given" do
      target_meal = create_meal(%{name: "foo bar baz"})
      _other_meal = create_meal(%{name: "abc 123"})
      assert Menu.list_meals(%{"q" => "bar"}) == [target_meal]
    end

    test "get_meal!/1 returns the meal with given id" do
      meal = create_meal()
      assert Menu.get_meal!(meal.id) == meal
    end
  end
end
