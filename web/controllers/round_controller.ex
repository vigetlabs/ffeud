defmodule FamilyFeud.RoundController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.Game
  alias FamilyFeud.Round

  plug FamilyFeud.RequireLoggedIn
  plug :load_game
  plug :authorize_game_access
  plug :authorize_round_access, "_" when action in [:edit, :update, :delete]

  def new(conn, params) do
    render conn, :new
  end

  def create(conn, %{"round" => round_params} = params) do
    case Round.create(round_params, conn.assigns[:game]) do
      {:ok, _round} ->
        conn
        |> put_flash(:info, "Round created")
        |> redirect(to: game_path(conn, :show, params["game_id"]))
      :error ->
        conn
        |> put_flash(:info, "Something went wrong with that")
        |> render(:new)
    end
  end

  def edit(conn, %{"id" => id}) do
    render conn, :edit, round: Repo.get(Round, id)
  end

  def update(conn, %{"id" => id, "round" => round_params} = params) do
    round = Repo.get(Round, id)

    case Round.update(round, round_params) do
      {:ok, _round} ->
        conn
        |> put_flash(:info, "Round updated")
        |> redirect(to: game_path(conn, :show, params["game_id"]))
      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Something went wrong with that")
        |> render(:edit)
    end
  end

  def delete(conn, %{"id" => id} = params) do
    round = Repo.get(Round, id)
    Repo.delete(round)

    conn
    |> put_flash(:info, "Round deleted")
    |> redirect(to: game_path(conn, :show, params["game_id"]))
  end

  def load_game(conn, _) do
    game = Repo.get(Game, conn.params["game_id"])
    assign(conn, :game, game)
  end

  def authorize_game_access(conn, _) do
    game = Repo.get(Game, conn.params["game_id"])
    if game && game.user_id == current_user(conn).id do
      conn
    else
      conn
      |> put_flash(:info, "You don't have access to that Game.")
      |> redirect(to: "/")
    end
  end

  def authorize_round_access(conn, _) do
    round = Repo.get_by(Round, id: conn.params["id"], game_id: conn.assigns[:game].id)

    if round do
      conn
    else
      conn
      |> put_flash(:info, "You don't have access to that Round.")
      |> redirect(to: "/")
    end
  end

end
