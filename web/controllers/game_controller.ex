defmodule FamilyFeud.GameController do
  use FamilyFeud.Web, :controller
  import FamilyFeud.ApplicationHelper, only: [current_user: 1]

  alias FamilyFeud.Repo
  alias FamilyFeud.Game

  plug FamilyFeud.RequireLoggedIn
  plug :authorize_access, "before show and delete" when action in [:show, :delete]

  def index(conn, _params) do
    user = current_user(conn) |> Repo.preload(:games)

    render conn, :index, games: user.games
  end

  def show(conn, %{"id" => game_id}) do
    render conn, :show, game: Repo.get(Game, game_id)
  end

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"game" => game_params}) do
    case Game.create(game_params, current_user(conn)) do
      {:ok, _game} ->
        conn
        |> put_flash(:info, "Game created")
        |> redirect(to: game_path(conn, :index))
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render(:new)
    end
  end

  def delete(conn, %{"id" => game_id}) do
     game = Repo.get(Game, game_id)
     Repo.delete(game)

    conn
    |> put_flash(:info, game.name <> " deleted")
    |> redirect(to: game_path(conn, :index))
  end

  def authorize_access(conn, _) do
    game = Repo.get(Game, conn.params["id"])
    if game && game.user_id == current_user(conn).id do
      conn
    else
      conn
      |> put_flash(:info, "You don't have access to that Game.")
      |> redirect(to: "/")
    end
  end

end
