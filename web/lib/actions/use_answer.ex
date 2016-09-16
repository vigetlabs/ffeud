defmodule FamilyFeud.Actions.UseAnswer do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game, index) do
    active_round = active_round_for(game)
    round        = round_for(active_round)
    answer       = Round.ordered_answers(round) |> Enum.at(index)

    new_pot_value    = active_round.pot + answer.points
    new_answer_state = active_round.answer_state |> List.replace_at(index, true)
    params           = %{pot: new_pot_value, answer_state: new_answer_state}
    if active_round.rebuttal, do: params = Map.put(params, :rebuttal, false)

    ActiveRound.update(active_round, params)
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
