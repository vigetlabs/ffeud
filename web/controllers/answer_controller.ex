require IEx
defmodule FamilyFeud.AnswerController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.Game
  alias FamilyFeud.Round
  alias FamilyFeud.Answer

  plug FamilyFeud.RequireLoggedIn
  plug :load_game
  plug :load_round
  plug :load_answer, "_" when action in [:edit, :update, :delete]
  plug :authorize_access

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"answer" => answer_params} = params) do
    case Answer.create(answer_params, conn.assigns[:round]) do
      {:ok, _answer} ->
        conn
        |> put_flash(:info, "Answer created")
        |> redirect(to: game_path(conn, :show, params["game_id"]))
      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Something went wrong with that")
        |> render(:new)
    end
  end

  def edit(conn, %{"id" => id}) do
    render conn, :edit, answer: Repo.get(Answer, id)
  end

  def update(conn, %{"id" => id, "answer" => answer_params} = params) do
    answer = Repo.get(Answer, id)

    case Answer.update(answer, answer_params) do
      {:ok, _answer} ->
        conn
        |> put_flash(:info, "Answer updated")
        |> redirect(to: game_path(conn, :show, params["game_id"]))
      {:error, _changeset} ->
        conn
        |> put_flash(:info, "Something went wrong with that")
        |> render(:edit, answer: answer)
    end
  end

  def delete(conn, %{"id" => id} = params) do
    answer = Repo.get(Answer, id)
    Repo.delete(answer)

    conn
    |> put_flash(:info, "Answer deleted")
    |> redirect(to: game_path(conn, :show, params["game_id"]))
  end

  def load_game(conn, _) do
    game = Repo.get_by(Game, id: conn.params["game_id"], user_id: current_user(conn).id)
    assign(conn, :game, game)
  end

  def load_round(conn, _) do
    if conn.assigns[:game] do
      round = Repo.get_by(Round, id: conn.params["round_id"], game_id: conn.assigns[:game].id)
      assign(conn, :round, round)
    else
      conn
    end
  end

  def load_answer(conn, _) do
    if conn.assigns[:round] do
      answer = Repo.get_by(Answer, id: conn.params["id"], round_id: conn.assigns[:round].id)
      assign(conn, :answer, answer)
    else
      conn
    end
  end

  def authorize_access(conn, _) do
    game   = conn.assigns[:game]
    round  = conn.assigns[:round]
    answer = conn.assigns[:answer]
    action = conn.private[:phoenix_action]

    access = if Enum.member?([:edit, :update, :delete], action) do
      game && round && answer
    else
      game && round
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
