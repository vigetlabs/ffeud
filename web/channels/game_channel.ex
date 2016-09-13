defmodule FamilyFeud.GameChannel do
  use Phoenix.Channel

  def join("game:lobby", %{"token" => token}, socket) do
    socket = assign(socket, :user, token)
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    IO.puts("handle_in")
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  intercept ["new_msg"]
  def handle_out("new_msg", payload, socket) do
    if socket.assigns[:user] == "public" do
      push socket, "new_msg", payload
    end
    {:noreply, socket}
  end
end
