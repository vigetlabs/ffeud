defmodule FamilyFeud.GameChannel do
  use Phoenix.Channel
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.ActiveGame

  def join("game:" <> game_id, %{"token" => token}, socket) do
    game = Repo.get(Game, game_id)

    socket = assign(socket, :user, token)
    socket = assign(socket, :active_game, Game.get_active_game(game))

    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  intercept ["new_msg"]
  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    push socket, "state", ActiveGame.get_state(socket.assigns[:active_game], socket.assigns[:user])

    {:noreply, socket}
  end
end
