defmodule FamilyFeud.GameController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.Game

  plug FamilyFeud.RequireLoggedIn
  plug :authorize_access, "-" when action in [:show, :delete, :edit, :update]

  def index(conn, _params) do
    render conn, :index,
      games: assoc(current_user(conn), :games) |> Repo.all
  end

  def show(conn, %{"id" => game_id}) do
    game = Repo.get(Game, game_id)

    render conn, :show,
      game:   game,
      rounds: Game.ordered_rounds(game)
  end

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"game" => game_params}) do
    case Game.create(game_params, current_user(conn)) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created")
        |> redirect(to: game_path(conn, :show, game))
      {:error, changeset} ->
        conn
        |> put_flash(:error, error_for(changeset))
        |> render(:new)
    end
  end

  def edit(conn, %{"id" => id}) do
    render conn, :edit, game: Repo.get(Game, id)
  end

  def update(conn, %{"id" => id, "game" => game_params} = params) do
    game = Repo.get(Game, id)

    case Game.update(game, game_params) do
      {:ok, _game} ->
        conn
        |> put_flash(:info, "Game updated")
        |> redirect(to: game_path(conn, :show, game))
      {:error, changeset} ->
        conn
        |> put_flash(:error, error_for(changeset))
        |> render(:edit, game: game)
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
      |> put_flash(:info, "You don't have access to that.")
      |> redirect(to: "/")
    end
  end

end
