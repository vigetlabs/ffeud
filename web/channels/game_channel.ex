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

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  intercept ["new_msg"]
  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    push socket, "state", GameState.get(socket.assigns[:game], socket.assigns[:user])

    {:noreply, socket}
  end
end
