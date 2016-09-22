defmodule FamilyFeud.FastMoneyRoundTest do
  use FamilyFeud.ModelCase

  alias FamilyFeud.FastMoneyRound

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FastMoneyRound.changeset(%FastMoneyRound{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FastMoneyRound.changeset(%FastMoneyRound{}, @invalid_attrs)
    refute changeset.valid?
  end
end
