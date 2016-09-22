defmodule FamilyFeud.Actions.FmStore do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveFastMoneyRound

  def act(game, type, index, value) do
    active_round = active_round_for(game)

    params = case type do
      "answer" ->
        %{answers: active_round.answers |> List.replace_at(index, value)}
      "point" ->
        %{points: active_round.points |> List.replace_at(index, value)}
    end

    ActiveFastMoneyRound.update(active_round, params)
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end
end
