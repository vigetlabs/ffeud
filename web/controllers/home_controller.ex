defmodule FamilyFeud.HomeController do
  use FamilyFeud.Web, :controller

  def index(conn, _params) do
    if logged_in?(conn) do
      redirect conn, to: "/games"
    else
      render conn, :index
    end
  end
end
