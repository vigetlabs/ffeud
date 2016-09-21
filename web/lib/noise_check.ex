defmodule FamilyFeud.NoiseCheck do
  def check("use_answer", %{"index" => index}) do
    if (index == 0), do: "right-first", else: "right"
  end

  def check("add_strike", _params) do
    "strike"
  end

  def check(_action, _params) do
    nil
  end
end
