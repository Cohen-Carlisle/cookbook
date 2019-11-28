defmodule Cookbook.MealFactory do
  @moduledoc """
  Provides functions to simplify Meal creation to facilitate testing.
  """

  alias Cookbook.Menu.Meal
  alias Cookbook.Repo

  def create_meal(params \\ %{}) do
    attrs = Map.merge(valid_attrs(), params)
    %Meal{} |> Meal.changeset(attrs) |> Repo.insert!()
  end

  def valid_attrs do
    %{first_seen: ~D[2010-04-17], img_url: "some img_url", last_seen: ~D[2010-04-17], name: inspect(make_ref()), note: "some note", time: 42}
  end
end
