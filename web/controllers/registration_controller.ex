defmodule FamilyFeud.RegistrationController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.User
  alias FamilyFeud.Registration
  alias FamilyFeud.Repo

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Registration.create(changeset, Repo) do
      {:ok, changeset} ->
        conn
        |> put_session(:current_user, changeset.id)
        |> put_flash(:info, "Your account was created")
        |> redirect to: "/"
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Unable to create account")
        |> render :new, changeset: changeset
    end
  end
end
