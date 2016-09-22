defmodule FamilyFeud.Actions.ResetGame do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound
  alias FamilyFeud.ActiveFastMoneyRound

  def act(game) do
    active_game  = active_game_for(game)
    active_round = active_round_for(active_game)

    ActiveGame.update(active_game, %{
      team_1_score: 0,
      team_2_score: 0
    })
    deactivate_round(active_round)
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(active_game) do
    ActiveGame.get_active_round(active_game)
  end

  def deactivate_round(active_round) do
    case active_round do
      %ActiveRound{} ->
        ActiveRound.update(active_round, %{active: false})
      %ActiveFastMoneyRound{} ->
        ActiveFastMoneyRound.update(active_round, %{active: false})
    end
  end
end
