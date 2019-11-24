defmodule Cookbook.Scraper.HelloFresh do
  @moduledoc """
  Scrapes HelloFresh meals from their menu endpoint.
  """
  require Logger
  alias Cookbook.Scraper.Helper

  @doc """
  Scrapes the HelloFresh meals for the given year and week, returning a list
  maps specifying each item's name and picture URL.

  The third parameter is used in unit testing to avoid doing an HTTP call.
  """
  @spec scrape(integer(), integer(), String.t() | nil) ::
          [%{name: String.t(), img_url: String.t()}]
  def scrape(year, week, endpoint_html \\ nil)
      when is_integer(year) and year >= 2017 and week in 1..53 do
    # re: guard clause: 52 weeks = 364 days, so occasionally a year will need 53
    endpoint_html(year, week, endpoint_html)
    |> parse_meal_elements()
    |> warn_if_no_meals({year, week, endpoint_html})
    |> elements_to_meals()
  end

  defp endpoint_html(year, week, nil) do
    # no retry but have never got anything but "200 OK"
    url = "https://www.hellofresh.com/menus/#{year}-W#{pad_week(week)}"
    {:ok, %{status_code: 200, body: body}} = HTTPoison.get(url)
    body
  end

  defp endpoint_html(_year, _week, endpoint_html) do
    endpoint_html
  end

  defp pad_week(week) do
    week |> Integer.to_string() |> String.pad_leading(2, "0")
  end

  defp parse_meal_elements(html) do
    selector =
      ~w[
        html
        body
        div:nth-of-type(1)
        section
        section:nth-of-type(3)
        section:nth-of-type(1)
        section
        span:nth-of-type(3)
      ]
      |> Enum.join(" > ")

    [{_tag, _attrs, meal_elements}] = Floki.find(html, selector)
    meal_elements
  end

  defp warn_if_no_meals(meals, args) do
    if Enum.empty?(meals) do
      Logger.warn(fn -> "#{__MODULE__} scraped no meals for args #{inspect(args)}" end)
    end

    meals
  end

  defp elements_to_meals(elements) do
    Enum.map(elements, fn element ->
      %{
        name: name(element),
        img_url: img_url(element),
        time: time(element),
        note: note(element)
      }
    end)
  end

  defp name(meal_element) do
    [short_name] = Floki.find(meal_element, "h4")
    [rest_of_name] = Floki.find(meal_element, "div[role='tooltip'] > div + span")
    Floki.text(short_name) <> " " <> Floki.text(rest_of_name)
  end

  defp img_url(meal_element) do
    [{_tag, attrs, _children}] = Floki.find(meal_element, "img")
    attrs |> Helper.attribute_value("src") |> full_size_image_url()
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

  defp time(meal_element) do
    meal_element |> Floki.find("div > div > span:first-of-type:fl-contains(' min')") |> do_time()
  end

  defp do_time([minutes]) do
    {time, " min"} = minutes |> Floki.text() |> Integer.parse()
    time
  end

  defp do_time([]) do
    nil
  end

  defp note(meal_element) do
    meal_element |> Floki.find("div > div > span:nth-of-type(2)") |> do_note()
  end

  defp do_note([note]) do
    Floki.text(note)
  end

  defp do_note([]) do
    nil
  end
end
