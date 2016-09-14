defmodule FamilyFeud.Game do
  use FamilyFeud.Web, :model
  alias FamilyFeud.Repo
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

  def for_user(user) do
    game_ids = Repo.all(
      from g in "games",
      where: g.user_id == ^user.id,
      select: g.id)

    Enum.map game_ids, fn(id) ->
      Repo.get(Game, id) |> Repo.preload(:user)
    end
  end
end
