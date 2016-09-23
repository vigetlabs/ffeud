defmodule FamilyFeud.Actions.FmShow do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveFastMoneyRound

  def act(game, type, index) do
    active_game  = active_game_for(game)
    active_round = active_round_for(game)

    if type == "answer" do
      params = %{answer_state: active_round.answer_state |> List.replace_at(index, true)}
      ActiveFastMoneyRound.update(active_round, params)
    else
      params = %{point_state: active_round.point_state |> List.replace_at(index, true)}
      ActiveFastMoneyRound.update(active_round, params)

      new_points  = Enum.at(active_round.points, index) || 0
      game_params = %{team_1_score: active_game.team_1_score + new_points}
      ActiveGame.update(active_game, game_params)
    end
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end
end
