import IEx
defmodule FamilyFeud.AnswerTest do
  use FamilyFeud.ModelCase

  @valid_attrs %{body: "some content", points: 42, round_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Answer.changeset(%Answer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Answer.changeset(%Answer{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "creating the 8th answer" do
    {:ok, user}  = User.create(User.changeset(%User{}, %{"email" => "e@example.com", "password" => "password"}))
    {:ok, game}  = Game.create(%{"name" => "Test Game"}, user)
    {:ok, round} = Round.create(%{"name" => "Test Round", "question" => "What?", "position" => 1}, game)

    Enum.each 1..7, fn(i) ->
      {:ok, answer} = Answer.create(%{"body" => "This", "points" => 1}, round)
    end

    changeset = Answer.changeset(%Answer{}, Map.put(@valid_attrs, :round_id, round.id))
    assert changeset.valid?
  end

  test "creating the 9th answer" do
    {:ok, user}  = User.create(User.changeset(%User{}, %{"email" => "e@example.com", "password" => "password"}))
    {:ok, game}  = Game.create(%{"name" => "Test Game"}, user)
    {:ok, round} = Round.create(%{"name" => "Test Round", "question" => "What?", "position" => 1}, game)

    Enum.each 1..8, fn(i) ->
      {:ok, answer} = Answer.create(%{"body" => "This", "points" => 1}, round)
    end

    changeset = Answer.changeset(%Answer{}, Map.put(@valid_attrs, :round_id, round.id))
    refute changeset.valid?
  end

  test "editing the 8th answer" do
    {:ok, user}  = User.create(User.changeset(%User{}, %{"email" => "e@example.com", "password" => "password"}))
    {:ok, game}  = Game.create(%{"name" => "Test Game"}, user)
    {:ok, round} = Round.create(%{"name" => "Test Round", "question" => "What?", "position" => 1}, game)

    answers = Enum.map 1..8, fn(i) ->
      {:ok, answer} = Answer.create(%{"body" => "This", "points" => 1}, round)
      answer
    end

    changeset = Answer.changeset(List.last(answers), Map.put(@valid_attrs, :round_id, round.id))
    assert changeset.valid?
  end
end
