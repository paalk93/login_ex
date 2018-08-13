defmodule LoginExWeb.Router do
  use LoginExWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LoginExWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/my_profile", UserController, :my_profile
    resources "/users", UserController

    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", LoginExWeb do
  #   pipe_through :api
  # end
end
