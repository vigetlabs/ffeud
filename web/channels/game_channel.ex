defmodule FamilyFeud.GameChannel do
  use Phoenix.Channel
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.GameState
  alias FamilyFeud.ActionHandler

  def join("game:" <> game_id, %{"token" => token}, socket) do
    socket = assign(socket, :user, token)
    socket = assign(socket, :game, Repo.get(Game, game_id))

    {:ok, socket}
  end

  def handle_in("load_state", _params, socket) do
    push socket, "state", GameState.get(socket.assigns[:game], socket.assigns[:user])
    {:noreply, socket}
  end

  def handle_in("act", params = %{"action" => action}, socket) do
    ActionHandler.handle(action, socket.assigns[:game], params)
    broadcast_state(socket)
    {:noreply, socket}
  end

  def broadcast_state(socket) do
    broadcast! socket, "state", GameState.get(socket.assigns[:game], socket.assigns[:user])
  end

  intercept ["state"]
  def handle_out("state", packet, socket) do
    push socket, "state", GameState.get(socket.assigns[:game], socket.assigns[:user])
    {:noreply, socket}
  end
end
