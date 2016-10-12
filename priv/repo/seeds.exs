# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FamilyFeud.Repo.insert!(%FamilyFeud.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FamilyFeud.Repo
alias FamilyFeud.User
alias FamilyFeud.Game
alias FamilyFeud.Round
alias FamilyFeud.Answer

user = Repo.all(User) |> List.first

{:ok, game}    = Game.create(%{"name" => "Example Game"}, user)
{:ok, round1}  = Round.create(%{"question" => "Name a beverage that is served at a kids birthday party", "position" => 1}, game)
{:ok, answer1} = Answer.create(%{"body" => "Kool Aid", "points" => 36}, round1)
{:ok, answer2} = Answer.create(%{"body" => "Punch", "points" => 34}, round1)
{:ok, answer3} = Answer.create(%{"body" => "Soda", "points" => 16}, round1)
{:ok, answer4} = Answer.create(%{"body" => "Lemonade", "points" => 10}, round1)
{:ok, answer5} = Answer.create(%{"body" => "Milk", "points" => 2}, round1)


{:ok, round2}  = Round.create(%{"question" => "Name a word a judge might yell out during a tennis match", "position" => 2}, game)
{:ok, answer6} = Answer.create(%{"body" => "Fault", "points" => 25}, round2)
{:ok, answer7} = Answer.create(%{"body" => "Foul", "points" => 17}, round2)
{:ok, answer8} = Answer.create(%{"body" => "Love", "points" => 14}, round2)
{:ok, answer9} = Answer.create(%{"body" => "Out", "points" => 10}, round2)
{:ok, answer10} = Answer.create(%{"body" => "Order", "points" => 6}, round2)
{:ok, answer11} = Answer.create(%{"body" => "Net", "points" => 4}, round2)
{:ok, answer12} = Answer.create(%{"body" => "Point", "points" => 3}, round2)
