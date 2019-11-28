defmodule Cookbook.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false
  alias Cookbook.Repo

  alias Cookbook.Menu.Meal
  alias Cookbook.SqlLike

  @doc """
  Returns the list of meals.

  ## Examples

      iex> list_meals(%{})
      [%Meal{}, ...]

  """
  def list_meals(%{"q" => search_term}) do
    sanitized_like_string = "%" <> SqlLike.sanitize(search_term) <> "%"
    query = from(m in Meal, where: ilike(m.name, ^sanitized_like_string))
    Repo.all(query)
  end

  def list_meals(_params) do
    Repo.all(Meal)
  end

  @doc """
  Gets a single meal.

  Raises `Ecto.NoResultsError` if the Meal does not exist.

  ## Examples

      iex> get_meal!(123)
      %Meal{}

      iex> get_meal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meal!(id) do
    Repo.get!(Meal, id)
  end
end
