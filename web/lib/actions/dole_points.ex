defmodule FamilyFeud.Actions.DolePoints do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

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
    ActiveRound.update(active_round, %{pot: 0})
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(active_game) do
    ActiveGame.get_active_round(active_game)
  end

  def round_for(active_round) do
    Round
    |> Repo.get(active_round.round_id)
    |> Repo.preload(:answers)
  end
end
