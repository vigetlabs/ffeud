defmodule FamilyFeud.Session do
  alias FamilyFeud.User
  alias FamilyFeud.Repo

  def login(params) do
    user = Repo.get_by(User, email: params["email"])
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
