defmodule CookbookWeb.AuthenticateUserPlug do
  import Plug.Conn, only: [assign: 3, get_session: 2]

  def init(options) do
    options
  end

  def call(conn, _opts) do
    # allow assigns to be set up and preserved for unit tests
    if Application.fetch_env!(:cookbook, :env) == :test and Map.has_key?(conn.assigns, :user) do
      conn
    else
      assign(conn, :user, get_session(conn, :user))
    end
  end
end
