defmodule FamilyFeud.GameState do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def get(game, access) do
    active_game  = Game.get_active_game(game)
    active_round = ActiveGame.get_active_round(active_game)
    round        = Repo.get(Round, active_round.round_id)
      |> Repo.preload(:answers)

    %{
      access:       access,
      pot:          active_game.pot,
      team_1_score: active_game.team_1_score,
      team_2_score: active_game.team_2_score,
      round_info:   %{
        question: round.question,
        x_count:  active_round.x_count,
        rebuttal: active_round.rebuttal,
        answers:  get_answers(round, active_round, access),
        done:     round_done?(active_round)
      }
    }
  end

  def get_answers(round, active_round, access) do
    answers = Round.ordered_answers(round)

    answers |> Enum.map fn(answer) ->
      index = Enum.find_index(answers, fn(x) -> x == answer end)

      if access == "admin" || Enum.at(active_round.answer_state, index) do
        %{
          body:   answer.body,
          points: answer.points,
          used:   Enum.at(active_round.answer_state, index)
        }
      else
        %{
          used: false
        }
      end
    end
  end

  def round_done?(active_round) do
    all_answered = Enum.all?(active_round.answer_state)
    struck_out   = (active_round.x_count >= 3 && !active_round.rebuttal)

    all_answered || struck_out
  end
end
