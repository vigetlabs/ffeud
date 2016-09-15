defmodule FamilyFeud.Actions.AddStrike do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game) do
    active_round = active_round_for(game)

    new_x_count = active_round.x_count + 1
    params      = %{x_count: new_x_count}
    if new_x_count == 3 do
      params = Map.put(params, :rebuttal, true)
    end

    ActiveRound.update(active_round, params)
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end
end
