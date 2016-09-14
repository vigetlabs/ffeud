defmodule FamilyFeud.GameController do
  use FamilyFeud.Web, :controller
  import FamilyFeud.ApplicationHelper, only: [current_user: 1]

  alias FamilyFeud.Repo
  alias FamilyFeud.Game

  def index(conn, _params) do
    render conn, :index,
      games: Game.for_user(current_user(conn))
  end

  def show(conn, %{"id" => game_id}) do
    render conn, :show, game: Repo.get(Game, game_id)
  end

  def new(conn, params) do
    render conn, :new
  end

  def create(conn, %{"game" => game_params}) do
    case Game.create(game_params, current_user(conn)) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created")
        |> redirect to: game_path(conn, :index)
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render :new
    end
  end

  def delete(conn, %{"id" => game_id}) do
     game = Repo.get(Game, game_id)
     Repo.delete(game)

    conn
    |> put_flash(:info, game.name <> " deleted")
    |> redirect to: game_path(conn, :index)
  end

end
