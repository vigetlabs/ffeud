defmodule FamilyFeud.Actions.DolePoints do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.FastMoneyRound
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound
  alias FamilyFeud.ActiveFastMoneyRound

  def act(game, team) do
    active_game   = active_game_for(game)
    active_round  = active_round_for(active_game)
    round         = round_for(active_round)
    earned_points = active_round.pot * round.multiplier

    params = case team do
      1 -> %{team_1_score: active_game.team_1_score + earned_points}
      2 -> %{team_2_score: active_game.team_2_score + earned_points}
    end

    ActiveGame.update(active_game, params)
    zero_out_pot(active_round)
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(active_game) do
    ActiveGame.get_active_round(active_game)
  end

  def round_for(active_round) do
    case active_round do
      %ActiveRound{} ->
        Repo.get(Round, active_round.round_id)
      %ActiveFastMoneyRound{} ->
        Repo.get(FastMoneyRound, active_round.fast_money_round_id)
    end
  end

  def zero_out_pot(active_round) do
    case active_round do
      %ActiveRound{} ->
        ActiveRound.update(active_round, %{pot: 0})
      %ActiveFastMoneyRound{} ->
        ActiveFastMoneyRound.update(active_round, %{pot: 0})
    end
  end
end
