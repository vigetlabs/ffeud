defmodule FamilyFeud.ApplicationHelper do
  alias FamilyFeud.Repo
  alias FamilyFeud.User

  def logged_in?(conn), do: !!current_user(conn)

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Repo.get(User, id)
  end
end
