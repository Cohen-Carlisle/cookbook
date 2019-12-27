defmodule CookbookWeb.AuthorizeUserPlug do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1]

  def init(options) do
    options
  end

  def call(conn, _opts) do
    if conn.assigns.user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to view that page.")
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
