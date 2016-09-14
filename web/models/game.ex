defmodule FamilyFeud.Game do
  use FamilyFeud.Web, :model
  alias FamilyFeud.Game

  schema "games" do
    field :name, :string
    belongs_to :user, FamilyFeud.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end

  def create(params, user) do
    params    = Map.put(params, "user_id", user.id)
    changeset = Game.changeset(%Game{}, params)

    Repo.insert(changeset)
  end
end
