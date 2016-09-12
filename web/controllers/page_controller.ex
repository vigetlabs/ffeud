defmodule FamilyFeud.PageController do
  use FamilyFeud.Web, :controller

  def index(conn, _params) do
    render conn, :index
  end

  def public(conn, _params) do
    render conn, :public
  end
end
