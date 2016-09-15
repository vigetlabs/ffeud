defmodule FamilyFeud.Actions.DolePoints do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame

  def act(game, team) do
    active_game = active_game_for(game)
    game_params = case team do
    1 ->
      %{team_1_score: active_game.team_1_score + active_game.pot, pot: 0}
    2 ->
      %{team_2_score: active_game.team_2_score + active_game.pot, pot: 0}
    end
    ActiveGame.update(active_game, game_params)
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end
end
