defmodule CookbookWeb.Router do
  use CookbookWeb, :router
  alias CookbookWeb.{AuthenticateUserPlug, AuthorizeUserPlug}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AuthenticateUserPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CookbookWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/meals", MealController, only: [:index, :show]
    get "/login", AccountController, :index
    post "/login", AccountController, :login
    get "/logout", AccountController, :logout
  end

  scope "/user", CookbookWeb do
    pipe_through [:browser, AuthorizeUserPlug]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookbookWeb do
  #   pipe_through :api
  # end
end
