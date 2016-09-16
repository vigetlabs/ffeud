defmodule FamilyFeud.Actions.NextRound do
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.ActiveRound

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

    ActiveRound.update(active_round, %{active: false})
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
    Repo.get(Round, active_round.round_id)
  end
end
