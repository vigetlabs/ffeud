defmodule FamilyFeud.Actions.DolePoints do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game, team) do
    active_game  = active_game_for(game)
    active_round = active_round_for(active_game)

    params = case team do
    1 ->
      %{team_1_score: active_game.team_1_score + active_round.pot}
    2 ->
      %{team_2_score: active_game.team_2_score + active_round.pot}
    end

    ActiveGame.update(active_game, params)
    ActiveRound.update(active_round, %{pot: 0})
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(active_game) do
    ActiveGame.get_active_round(active_game)
  end
end
