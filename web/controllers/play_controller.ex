defmodule FamilyFeud.PlayController do
  use FamilyFeud.Web, :controller
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame
  alias FamilyFeud.LayoutView

  plug :load_game
  plug :require_game

  def admin(conn, _params) do
    active_game = Game.get_active_game(conn.assigns[:game])
    ActiveGame.get_active_round(active_game)

    render conn, :admin
  end

  def public(conn, _params) do
    render conn, :public, layout: {LayoutView, :public}
  end

  def load_game(conn, _) do
    game = case conn.params do
      %{"public_code" => code} ->
        Repo.get_by(Game, public_code: code)
      %{"game_id" => "42"} ->
        Repo.get_by(Game, id: 42)
      %{"game_id" => id} ->
        if current_user(conn) do
          Repo.get_by(Game, id: id, user_id: current_user(conn).id)
        end
    end

    assign(conn, :game, game)
  end

  def require_game(conn, _) do
    game = conn.assigns[:game]
    if game do
      conn
    else
      conn
      |> put_flash(:info, "Page not found")
      |> redirect(to: "/")
    end
  end

end
