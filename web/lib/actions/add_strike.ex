defmodule FamilyFeud.Actions.AddStrike do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game, team) do
    active_round = active_round_for(game)

    params = case team do
      1 -> %{team_1_x_count: active_round.team_1_x_count + 1}
      2 -> %{team_2_x_count: active_round.team_2_x_count + 1}
    end

    ActiveRound.update(active_round, params)
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end
end
