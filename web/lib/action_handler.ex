defmodule FamilyFeud.ActionHandler do
  def handle("use_answer", game, %{"index" => index}) do
    FamilyFeud.Actions.UseAnswer.act(game, index)
  end

  def handle("add_strike", game, _params) do
    FamilyFeud.Actions.AddStrike.act(game)
  end

  def handle("dole_points", game, %{"team" => team}) do
    FamilyFeud.Actions.DolePoints.act(game, team)
  end

  def handle("next_round", game, _params) do
    FamilyFeud.Actions.NextRound.act(game)
  end

  def handle("reset_game", game, _params) do
    FamilyFeud.Actions.ResetGame.act(game)
  end
end
