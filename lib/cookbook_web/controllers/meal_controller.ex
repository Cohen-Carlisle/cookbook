defmodule CookbookWeb.MealController do
  use CookbookWeb, :controller

  alias Cookbook.Menu

  def index(conn, params) do
    meals = Menu.list_meals(params)
    render(conn, "index.html", meals: meals)
  end

  def show(conn, %{"id" => id}) do
    meal = Menu.get_meal!(id)
    render(conn, "show.html", meal: meal)
  end
end
