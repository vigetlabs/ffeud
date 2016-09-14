defmodule FamilyFeud.AnswerTest do
  use FamilyFeud.ModelCase

  alias FamilyFeud.Answer

  @valid_attrs %{body: "some content", points: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Answer.changeset(%Answer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Answer.changeset(%Answer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
