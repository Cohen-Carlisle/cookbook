defmodule CookbookWeb.MealControllerTest do
  use CookbookWeb.ConnCase

  alias Cookbook.Menu.Meal
  alias Cookbook.Repo

  @valid_attrs %{first_seen: ~D[2010-04-17], img_url: "some img_url", last_seen: ~D[2010-04-17], name: "some name", note: "some note", time: 42}

  describe "index" do
    test "lists all meals", %{conn: conn} do
      conn = get(conn, Routes.meal_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Meals"
    end
  end

  describe "show meal" do
    test "shows chosen meal", %{conn: conn} do
      meal = %Meal{} |> Meal.changeset(@valid_attrs) |> Repo.insert!()
      conn = get(conn, Routes.meal_path(conn, :show, meal.id))
      assert html_response(conn, 200) =~ "Show Meal"
    end
  end
end
