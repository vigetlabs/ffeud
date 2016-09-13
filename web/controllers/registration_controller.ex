defmodule FamilyFeud.RegistrationController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.User
  alias FamilyFeud.Registration

  plug FamilyFeud.RequireLoggedOut, "before new and create" when action in [:new, :create]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case User.create(changeset) do
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
