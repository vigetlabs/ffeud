defmodule FamilyFeud.ActionHandler do
  def handle("use_answer", game, %{"index" => index}) do
    FamilyFeud.Actions.UseAnswer.act(game, index)
  end

  def handle("reveal_answer", game, %{"index" => index}) do
    FamilyFeud.Actions.RevealAnswer.act(game, index)
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

  def handle("edit_data", game, %{"field" => field, "value" => value}) do
    FamilyFeud.Actions.EditData.act(game, field, value)
  end

  def handle("fm_store", game, %{"type" => type, "index" => index, "value" => value}) do
    FamilyFeud.Actions.FmStore.act(game, type, index, value)
  end

  def handle("fm_show", game, %{"type" => type, "index" => index}) do
    FamilyFeud.Actions.FmShow.act(game, type, index)
  end

end
