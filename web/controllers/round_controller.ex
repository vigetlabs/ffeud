defmodule FamilyFeud.RoundController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.Game
  alias FamilyFeud.Round

  plug FamilyFeud.RequireLoggedIn
  plug :load_game
  plug :load_round, "_" when action in [:edit, :update, :delete]
  plug :authorize_access

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"round" => round_params} = params) do
    case Round.create(round_params, conn.assigns[:game]) do
      {:ok, _round} ->
        conn
        |> put_flash(:info, "Round created")
        |> redirect(to: game_path(conn, :show, params["game_id"]))
      {:error, _changeset} ->
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
        |> render(:edit, round: round)
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
    game = Repo.get_by(Game, id: conn.params["game_id"], user_id: current_user(conn).id)
    assign(conn, :game, game)
  end

  def load_round(conn, _) do
    if conn.assigns[:game] do
      round = Repo.get_by(Round, id: conn.params["id"], game_id: conn.assigns[:game].id)
      assign(conn, :round, round)
    else
      conn
    end
  end

  def authorize_access(conn, _) do
    game   = conn.assigns[:game]
    round  = conn.assigns[:round]
    action = conn.private[:phoenix_action]

    access = if Enum.member?([:edit, :update, :delete], action) do
      game && round
    else
      game
    end

    if access do
      conn
    else
      conn
      |> put_flash(:info, "You don't have access to that.")
      |> redirect(to: "/")
    end
  end
end
