defmodule FamilyFeud.ActiveFastMoneyRound do
  use FamilyFeud.Web, :model

  schema "active_fast_money_rounds" do
    field :answers, {:array, :string}
    field :points, {:array, :integer}
    field :answer_state, {:array, :boolean}
    field :point_state, {:array, :boolean}
    field :active, :boolean, default: true
    field :last_round, :boolean, default: false
    field :pot, :integer, default: 0
    belongs_to :active_game, ActiveGame
    belongs_to :fast_money_round, FamilyFeud.FastMoneyRound

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:answers, :points, :answer_state, :point_state, :active, :last_round, :pot, :active_game_id, :fast_money_round_id])
    |> validate_required([:answers, :points, :answer_state, :point_state, :active, :last_round, :pot, :active_game_id, :fast_money_round_id])
  end

  def create(active_game, fast_money_round) do
    changeset(%ActiveFastMoneyRound{}, %{
      active_game_id:      active_game.id,
      fast_money_round_id: fast_money_round.id,
      answers:             Enum.map(1..5, fn(_) -> "" end),
      points:              Enum.map(1..5, fn(_) -> nil end),
      answer_state:        Enum.map(1..5, fn(_) -> false end),
      point_state:         Enum.map(1..5, fn(_) -> false end)
    })
    |> Repo.insert
  end
end
