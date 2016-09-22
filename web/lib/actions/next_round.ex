defmodule FamilyFeud.Actions.NextRound do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.FastMoneyRound
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound
  alias FamilyFeud.ActiveFastMoneyRound

  def act(game) do
    # find next round
    # deactivate current active_round
    # make new active_round

    active_game    = active_game_for(game)
    active_round   = active_round_for(active_game)
    round          = current_round_for(active_round)
    ordered_rounds = rounds_for(game)

    round_index = ordered_rounds |> Enum.find_index(fn(r) -> r == round end)
    next_round  = ordered_rounds |> Enum.at(round_index + 1)

    deactivate_round(active_round)
    ActiveGame.get_active_round(active_game, next_round)
  end

  def active_game_for(game) do
    Game.get_active_game(game)
  end

  def active_round_for(active_game) do
    ActiveGame.get_active_round(active_game)
  end

  def rounds_for(game) do
    Game.ordered_rounds(game)
  end

  def current_round_for(active_round) do
    case active_round do
      %ActiveRound{} ->
        Repo.get(Round, active_round.round_id)
      %ActiveFastMoneyRound{} ->
        Repo.get(FastMoneyRound, active_round.fast_money_round_id)
    end
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
