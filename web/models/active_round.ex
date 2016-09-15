defmodule FamilyFeud.ActiveRound do
  use FamilyFeud.Web, :model

  schema "active_rounds" do
    field :active, :boolean, default: true
    field :answer_state, {:array, :boolean}, default: []
    field :x_count, :integer, default: 0
    belongs_to :active_game, ActiveGame
    belongs_to :round, Round

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:active, :answer_state, :x_count, :active_game_id, :round_id])
    |> validate_required([:active, :answer_state, :x_count, :active_game_id, :round_id])
  end

  def create(active_game, round) do
    round = Repo.preload(round, :answers)

    changeset(%ActiveRound{}, %{
      active_game_id: active_game.id,
      round_id: round.id,
      answer_state:  Enum.map(1..Enum.count(round.answers), fn(_) -> false end)
    })
    |> Repo.insert
  end
end
