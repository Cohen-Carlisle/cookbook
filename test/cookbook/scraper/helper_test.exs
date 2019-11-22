defmodule Cookbook.Scraper.HelperTest do
  use Cookbook.DataCase
  alias Cookbook.Scraper.Helper

  describe "attribute_value/2" do
    test "returns the value of the attribute specified by `attr_name`" do
      assert Helper.attribute_value([{"alt", "text"}], "alt") == "text"
    end

    test "returns the first value if there are multiple attributes by the same name" do
      assert Helper.attribute_value([{"data-oops", "1"}, {"data-oops", "2"}], "data-oops") == "1"
    end

    test "returns nil if there is no attribute by the specified name" do
      assert Helper.attribute_value([{"href", "/path"}], "alt") == nil
    end

    test "only accepts a list for `attributes`" do
      assert_raise FunctionClauseError, fn ->
        Helper.attribute_value(%{"href" => "/path"}, "href")
      end
    end

    test "only accepts a string for `attr_name`" do
      assert_raise FunctionClauseError, fn ->
        Helper.attribute_value([{"href", "/path"}], :href)
      end
    end
  end
end
