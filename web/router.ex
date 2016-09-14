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

    get "/", HomeController, :index

    resources "/games", GameController do
      resources "/rounds", RoundController do
        resources "/answers", AnswerController do
        end
      end
    end

    resources "/registrations", RegistrationController,
      only: [:new, :create]

    get  "/login",  SessionController, :new
    post "/login",  SessionController, :create
    get  "/logout", SessionController, :delete
  end
end
