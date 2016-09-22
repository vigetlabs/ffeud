defmodule FamilyFeud.FastMoneyRound do
  use FamilyFeud.Web, :model

  schema "fast_money_rounds" do
    belongs_to :game, FamilyFeud.Game
    field :notes, :string
    field :position, :integer
    field :multiplier, :integer, default: 1

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:game_id, :notes, :position])
    |> validate_required([:game_id, :notes, :position])
  end

  def create(params, game) do
    params = Map.put(params, "game_id", game.id)

    changeset(%FastMoneyRound{}, params) |> Repo.insert
  end
end
