defmodule FamilyFeud.Actions.EditData do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

  def act(game, "team_" <> id, value) do
    active_game = active_game_for(game)

    params = case id do
      "1" -> %{team_1_score: value}
      "2" -> %{team_2_score: value}
    end

    ActiveGame.update(active_game, params)
  end

  def act(game, "multiplier", value) do
    active_round = active_round_for(game)
    round        = round_for(active_round)

    Round.update(round, %{multiplier: value})
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(game) do
    game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
  end

  def round_for(active_round) do
    Repo.get(Round, active_round.round_id)
  end
end
