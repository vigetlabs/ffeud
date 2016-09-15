defmodule FamilyFeud.User do
  use FamilyFeud.Web, :model

  schema "users" do
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true

    has_many :games, Game

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 4)
    |> unique_constraint(:email)
  end

  def create(changeset) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> Repo.insert()
  end

  def hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
