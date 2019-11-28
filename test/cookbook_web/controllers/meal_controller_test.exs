defmodule CookbookWeb.MealControllerTest do
  use CookbookWeb.ConnCase

  import Cookbook.MealFactory

  describe "index" do
    test "lists all meals", %{conn: conn} do
      conn = get(conn, Routes.meal_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Meals"
    end
  end

  describe "show meal" do
    test "shows chosen meal", %{conn: conn} do
      meal = create_meal()
      conn = get(conn, Routes.meal_path(conn, :show, meal.id))
      assert html_response(conn, 200) =~ "Show Meal"
    end
  end
end
