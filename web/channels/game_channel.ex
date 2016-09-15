defmodule FamilyFeud.GameChannel do
  use Phoenix.Channel
  alias FamilyFeud.Repo
  alias FamilyFeud.Game
  alias FamilyFeud.GameState

  def join("game:" <> game_id, %{"token" => token}, socket) do
    socket = assign(socket, :user, token)
    socket = assign(socket, :game, Repo.get(Game, game_id))

    {:ok, socket}
  end

  def handle_in("update_state", _params, socket) do
    broadcast! socket, "state", GameState.get(socket.assigns[:game], socket.assigns[:user])
    {:noreply, socket}
  end
end
