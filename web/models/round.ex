defmodule FamilyFeud.Round do
  use FamilyFeud.Web, :model
  alias FamilyFeud.Round

  schema "rounds" do
    field :question, :string
    field :position, :integer
    belongs_to :game, FamilyFeud.Game

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :position, :game_id])
    |> validate_required([:question, :position, :game_id])
  end

  def create(params, game) do
    params = Map.put(params, "game_id", game.id)

    changeset(%Round{}, params) |> Repo.insert
  end

  def update(round, params) do
    changeset(round, params) |> Repo.update
  end
end
