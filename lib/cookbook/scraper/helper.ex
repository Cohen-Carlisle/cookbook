defmodule Cookbook.Scraper.Helper do
  @moduledoc """
  Helper functions for scraping web pages.
  """

  @doc """
  Takes a list of `attributes` (as given by `&Floki.find/2`) and returns the
  value of the attribute specified by `attr_name`
  """
  @spec attribute_value([{String.t(), String.t()}], String.t()) :: String.t() | nil
  def attribute_value(attributes, attr_name) when is_list(attributes) and is_binary(attr_name) do
    attributes
    |> List.keyfind(attr_name, 0, {attr_name, nil})
    |> elem(1)
  end
end
