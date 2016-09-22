defmodule FamilyFeud.FastMoneyRoundController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.Game
  alias FamilyFeud.FastMoneyRound

  plug FamilyFeud.RequireLoggedIn
  plug :load_game
  plug :authorize_access

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"fast_money_round" => round_params} = params) do
    case FastMoneyRound.create(round_params, conn.assigns[:game]) do
      {:ok, _round} ->
        conn
        |> put_flash(:info, "Fast Money Round created")
        |> redirect(to: game_path(conn, :show, params["game_id"]))
      {:error, changeset} ->
        conn
        |> put_flash(:error, error_for(changeset))
        |> render(:new)
    end
  end

  def edit(conn, %{"id" => id}) do
    render conn, :edit, round: Repo.get(FastMoneyRound, id)
  end

  def update(conn, %{"id" => id, "fast_money_round" => round_params} = params) do
    round = Repo.get(FastMoneyRound, id)

    case FastMoneyRound.update(round, round_params) do
      {:ok, _round} ->
        conn
        |> put_flash(:info, "Fast Money Round updated")
        |> redirect(to: game_path(conn, :show, params["game_id"]))
      {:error, changeset} ->
        conn
        |> put_flash(:error, error_for(changeset))
        |> render(:edit, round: round)
    end
  end

  def delete(conn, %{"id" => id} = params) do
    round = Repo.get(FastMoneyRound, id)
    Repo.delete(round)

    conn
    |> put_flash(:info, "Fast Money Round deleted")
    |> redirect(to: game_path(conn, :show, params["game_id"]))
  end

  def load_game(conn, _) do
    game = Repo.get_by(Game, id: conn.params["game_id"], user_id: current_user(conn).id)
    assign(conn, :game, game)
  end

  def authorize_access(conn, _) do
    if conn.assigns[:game] do
      conn
    else
      conn
      |> put_flash(:info, "You don't have access to that.")
      |> redirect(to: "/")
    end
  end
end
