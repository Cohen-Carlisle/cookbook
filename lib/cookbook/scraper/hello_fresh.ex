defmodule Cookbook.Scraper.HelloFresh do
  @moduledoc """
  Scrapes HelloFresh recipes from their menu endpoint.
  """
  require Logger
  alias Cookbook.Scraper.Helper

  @doc """
  Scrapes the HelloFresh recipes for the given year and week, returning a list
  maps specifying each item's name and picture URL.
  """
  @spec scrape(integer(), integer()) :: [%{name: String.t(), img_src: String.t()}]
  def scrape(year, week) when is_integer(year) and year >= 2017 and week in 1..53 do
    # 52 weeks is 364 days. occasionally a year will need 53.
    # TODO retry
    url = "https://www.hellofresh.com/menus/#{year}-W#{pad_week(week)}"
    {:ok, %{status_code: 200, body: body}} = HTTPoison.get(url)

    img_elements = Floki.find(body, "img")
    recipe_elements = Enum.filter(img_elements, &recipe_element?/1)
    recipes = elements_to_recipes(recipe_elements)

    if Enum.empty?(recipes) do
      Logger.warn(fn -> "#{__MODULE__} scraped no recipes for #{inspect({year, week})}" end)
    end

    recipes
  end

  defp pad_week(week) do
    week |> Integer.to_string() |> String.pad_leading(2, "0")
  end

  defp recipe_element?({_tag, attrs, _children}) do
    # the class on recipe images seems to change randomly
    # right now it is "dsr"
    {_name, value} = List.keyfind(attrs, "alt", 0, {"alt", "HelloFresh"})
    value != "HelloFresh"
  end

  defp elements_to_recipes(elements) do
    Enum.map(elements, fn {_tag, attrs, _children} ->
      %{
        name: attrs |> Helper.attribute_value("alt"),
        img_src: attrs |> Helper.attribute_value("src") |> full_size_image_url()
      }
    end)
  end

  defp full_size_image_url(url) do
    # get the full size url by chopping off path params that modify the image
    # e.g., remove "/c_fill,f_auto,fl_lossy,h_432,q_auto,w_768" from path
    uri = URI.parse(url)

    if String.starts_with?(uri.path, "/hellofresh_s3") do
      url
    else
      new_path = String.replace(uri.path, ~r{/[^/]+}, "", global: false)
      URI.to_string(%{uri | path: new_path})
    end
  end
end
