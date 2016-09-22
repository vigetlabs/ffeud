defmodule FamilyFeud.Actions.FmShow do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveFastMoneyRound

  def act(game, type, index) do
    active_round = active_round_for(game)

    params = case type do
      "answer" ->
        %{answer_state: active_round.answer_state |> List.replace_at(index, true)}
      "point" ->
        new_points = Enum.at(active_round.points, index) || 0
        %{
          pot:         active_round.pot + new_points,
          point_state: active_round.point_state |> List.replace_at(index, true)
        }
    end

    ActiveFastMoneyRound.update(active_round, params)
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end
end
