defmodule Cookbook.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Cookbook.Repo
  alias Cookbook.Account.User

  @doc """
  Gets a single user by username.
  Returns `{:ok, user}` or `{:error, :user_not_found}`.

  ## Examples

      iex> get_user("exists")
      {:ok, %Pharmacy{username: "exists"}}

      iex> get_user("nonexistent")
      {:error, :user_not_found}

  """
  def get_user(username) do
    case Repo.get_by(User, username: username) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :user_not_found}
    end
  end
end
