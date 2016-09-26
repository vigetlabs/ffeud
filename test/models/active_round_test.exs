defmodule FamilyFeud.ActiveRoundTest do
  use FamilyFeud.ModelCase

  alias FamilyFeud.ActiveRound

  @valid_attrs %{active: true, pot: 0, answer_state: [], x_count: 42, rebuttal: true, last_round: true, active_game_id: 1, round_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ActiveRound.changeset(%ActiveRound{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ActiveRound.changeset(%ActiveRound{}, @invalid_attrs)
    refute changeset.valid?
  end
end
