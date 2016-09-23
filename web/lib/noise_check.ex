defmodule FamilyFeud.NoiseCheck do
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame

  def check("use_answer", %{"index" => index}, _game) do
    if (index == 0), do: "right-first", else: "right"
  end

  def check("add_strike", _params, _game) do
    "strike"
  end

  def check("fm_show", %{"type" => "answer"}, _game) do
    "fm-answer"
  end

  def check("fm_show", %{"type" => "point", "index" => index}, game) do
    active_round = game
    |> Game.get_active_game
    |> ActiveGame.get_active_round
    new_points = Enum.at(active_round.points, index) || 0

    if new_points > 0 do
      "fm-bell"
    else
      "fm-strike"
    end
  end

  def check(_action, _params, _game) do
    nil
  end
end
