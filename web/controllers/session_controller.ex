defmodule FamilyFeud.SessionController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.Session

  plug FamilyFeud.RequireLoggedOut, "before new and create" when action in [:new, :create]

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"session" => session_params}) do
    case Session.login(session_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render(:new)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
