defmodule FamilyFeud.Actions.UseAnswer do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game, index, team) do
    active_game  = active_game_for(game)
    active_round = active_round_for(game)
    round        = round_for(active_round)
    answer       = Round.ordered_answers(round) |> Enum.at(index)

    game_params = case team do
      1 -> %{team_1_score: active_game.team_1_score + answer.points}
      2 -> %{team_2_score: active_game.team_2_score + answer.points}
    end
    ActiveGame.update(active_game, game_params)

    new_answer_state = active_round.answer_state |> List.replace_at(index, true)
    ActiveRound.update(active_round, %{answer_state: new_answer_state})
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end

  def round_for(active_round) do
    Round
    |> Repo.get(active_round.round_id)
    |> Repo.preload(:answers)
  end
end
