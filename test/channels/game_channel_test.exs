defmodule FamilyFeud.GameChannelTest do
  use FamilyFeud.ChannelCase

  alias FamilyFeud.GameChannel

  setup do
    {:ok, user}   = User.create(User.changeset(%User{}, %{"email" => "e@example.com", "password" => "password"}))
    {:ok, game}   = Game.create(%{"name" => "Test Game"}, user)
    {:ok, round}  = Round.create(%{"name" => "Test Round", "question" => "What?", "position" => 1}, game)
    Answer.create(%{"body" => "First Answer", "points" => 10}, round)

    {:ok, game: game}
  end

  describe "as an admin" do
    setup %{game: game} do
      {:ok, _, socket} =
        socket("user", %{})
        |> subscribe_and_join(GameChannel, "game:#{game.id}", %{"token" => "admin"})

      {:ok, socket: socket}
    end

    test "load_state replies with state", %{socket: socket} do
      push socket, "load_state", %{}

      assert_push "state", %{
        access:     "admin",
        round_info: %{
          answers: [%{
            body: "First Answer", points: 10, used: false
          }],
          done:       false,
          last_round: true,
          multiplier: 1,
          pot:        0,
          question:   "What?",
          rebuttal:   false,
          x_count:    0
        },
        round_type:   "regular",
        team_1_name:  "Team 1",
        team_1_score: 0,
        team_2_name:  "Team 2",
        team_2_score: 0
      }
    end
  end

  describe "as a public user" do
    setup %{game: game} do
      {:ok, _, socket} =
        socket("user", %{})
        |> subscribe_and_join(GameChannel, "game:#{game.id}", %{"token" => "public"})

      {:ok, socket: socket}
    end

    test "load_state replies with state", %{socket: socket} do
      push socket, "load_state", %{}

      assert_push "state", %{
        access:     "public",
        round_info: %{
          answers:    [%{used: false}],
          done:       false,
          last_round: true,
          multiplier: 1,
          pot:        0,
          question:   "What?",
          rebuttal:   false,
          x_count:    0
        }
      }
    end
  end

end
