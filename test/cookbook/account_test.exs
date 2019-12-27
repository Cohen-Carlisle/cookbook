defmodule Cookbook.AccountTest do
  use Cookbook.DataCase
  alias Cookbook.Account
  alias Cookbook.Account.User

  describe "users" do
    @valid_attrs %{username: "Valid User"}

    def user_fixture(attrs) do
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert!()
    end

    test "get_user/1 returns the user with given username in an ok tuple" do
      user = user_fixture(@valid_attrs)
      assert Account.get_user(@valid_attrs.username) == {:ok, user}
    end

    test "get_user/1 returns an error tuple if no user found" do
      assert Account.get_user("nope") == {:error, :user_not_found}
    end
  end
end
