defmodule FamilyFeud.ActiveFastMoneyRoundTest do
  use FamilyFeud.ModelCase

  alias FamilyFeud.ActiveFastMoneyRound

  @valid_attrs %{active: true, answer_state: [], answers: [], last_round: true, point_state: [], pot: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ActiveFastMoneyRound.changeset(%ActiveFastMoneyRound{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ActiveFastMoneyRound.changeset(%ActiveFastMoneyRound{}, @invalid_attrs)
    refute changeset.valid?
  end
end
