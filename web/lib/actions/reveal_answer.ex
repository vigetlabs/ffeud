defmodule FamilyFeud.Actions.RevealAnswer do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game, index) do
    active_round     = active_round_for(game)
    new_answer_state = active_round.answer_state |> List.replace_at(index, true)

    ActiveRound.update(active_round, %{answer_state: new_answer_state})
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end

end
