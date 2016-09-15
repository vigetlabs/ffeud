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
    last_round  = List.last(ordered_rounds) == next_round

    ActiveRound.update(active_round, %{active: false})
    new_active_round = ActiveGame.get_active_round(active_game, next_round)

    if last_round do
      ActiveRound.update(new_active_round, %{last_round: true})
    end
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
