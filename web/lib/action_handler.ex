defmodule FamilyFeud.ActionHandler do
  alias FamilyFeud.Actions.UseAnswer
  alias FamilyFeud.Actions.AddStrike
  alias FamilyFeud.Actions.DolePoints

  def handle("use_answer", game, %{"index" => index}) do
    UseAnswer.act(game, index)
  end

  def handle("add_strike", game, _params) do
    AddStrike.act(game)
  end

  def handle("dole_points", game, %{"team" => team}) do
    DolePoints.act(game, team)
  end
end
