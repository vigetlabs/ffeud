defmodule FamilyFeud.GameState do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def get(game, access) do
    game         = Repo.get(Game, game.id)
    active_game  = Game.get_active_game(game)
    active_round = ActiveGame.get_active_round(active_game)
    round        = Repo.get(Round, active_round.round_id)
      |> Repo.preload(:answers)

    %{
      access:       access,
      team_1_name:  game.team_1_name,
      team_2_name:  game.team_2_name,
      team_1_score: active_game.team_1_score,
      team_2_score: active_game.team_2_score,
      round_info:   %{
        pot:        active_round.pot,
        multiplier: round.multiplier,
        question:   round.question,
        answers:    get_answers(round, active_round, access),
        x_count:    active_round.x_count,
        rebuttal:   active_round.rebuttal,
        done:       round_done?(active_round),
        last_round: active_round.last_round
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
