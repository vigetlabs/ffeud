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

  def get_state(active_round, access) do
    round = Repo.get(Round, active_round.round_id) |> Repo.preload(:answers)

    %{
      question: round.question,
      x_count:  active_round.x_count,
      answers:  get_answers(round, active_round, access)
    }
  end

  def get_answers(round, active_round, "admin") do
    answers = Round.ordered_answers(round)

    answers |> Enum.map fn(answer) ->
      index = Enum.find_index(answers, fn(x) -> x == answer end)

      %{
        body:   answer.body,
        points: answer.points,
        used:   Enum.at(active_round.answer_state, index)
      }
    end
  end

  def get_answers(round, active_round, "public") do
    answers = Round.ordered_answers(round)

    answers |> Enum.map fn(answer) ->
      index = Enum.find_index(answers, fn(x) -> x == answer end)

      if Enum.at(active_round.answer_state, index) do
        %{
          used:   true,
          body:   answer.body,
          points: answer.points
        }
      else
        %{
          used:  false,
          index: index + 1
        }
      end
    end
  end
end
