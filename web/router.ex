defmodule FamilyFeud.Router do
  use FamilyFeud.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", FamilyFeud do
    pipe_through :browser

    get "/",       PageController, :index
    get "/public", PageController, :public
  end
end
