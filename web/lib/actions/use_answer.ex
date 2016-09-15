defmodule FamilyFeud.Actions.UseAnswer do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game, index) do
    active_game  = active_game_for(game)
    active_round = active_round_for(active_game)
    round        = round_for(active_round)
    answer       = Round.ordered_answers(round) |> Enum.at(index)

    new_pot_value = active_game.pot + answer.points
    ActiveGame.update(active_game, %{pot: new_pot_value})

    new_answer_state = active_round.answer_state |> List.replace_at(index, true)
    ActiveRound.update(active_round, %{answer_state: new_answer_state})
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(active_game) do
    ActiveGame.get_active_round(active_game)
  end

  def round_for(active_round) do
    Round
    |> Repo.get(active_round.round_id)
    |> Repo.preload(:answers)
  end
end
