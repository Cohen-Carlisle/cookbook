defmodule CookbookWeb.AccountController do
  use CookbookWeb, :controller
  alias Cookbook.Account

  def index(conn, _params) do
    case conn.assigns.user do
      nil ->
        render(conn, "index.html")

      user ->
        conn
        |> put_flash(:info, "Already logged in as #{user.username}.")
        |> redirect(to: Routes.meal_path(conn, :index))
    end
  end

  def login(conn, %{"username" => username}) do
    case Account.get_user(username) do
      {:ok, user} ->
        conn
        |> put_session(:user, %{username: user.username, id: user.id})
        |> put_flash(:info, "Welcome to Cookbook, #{user.username}.")
        |> redirect(to: Routes.meal_path(conn, :index))

      {:error, :user_not_found} ->
        conn
        |> put_flash(:error, "Sorry, that user was not found.")
        |> redirect(to: Routes.account_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> clear_session()
    |> put_flash(:info, "You have been logged out.")
    |> redirect(to: Routes.account_path(conn, :index))
  end
end
