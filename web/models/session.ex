defmodule FamilyFeud.Session do
  alias FamilyFeud.User
  alias FamilyFeud.Repo

  def logged_in?(conn), do: !!current_user(conn)

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Repo.get(User, id)
  end

  def login(params, repo) do
    user = repo.get_by(User, email: params["email"])
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  def authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end
