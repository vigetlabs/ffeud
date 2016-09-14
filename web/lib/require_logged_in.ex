defmodule FamilyFeud.RequireLoggedIn do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn

  def init(default), do: default

  def call(conn, _params) do
    if !FamilyFeud.ApplicationHelper.logged_in?(conn) do
      conn
      |> put_flash(:info, "You must be logged in to view that page.")
      |> redirect to: "/"
    else
      conn
    end
  end

end
