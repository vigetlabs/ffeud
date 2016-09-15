defmodule FamilyFeud.ActiveRoundTest do
  use FamilyFeud.ModelCase

  alias FamilyFeud.ActiveRound

  @valid_attrs %{active: true, answer_state: "some content", x_count: 42}
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
