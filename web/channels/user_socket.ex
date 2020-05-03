defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel("comments_for_topic:*", Discuss.CommentsChannel)
  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(%{"token" => token}, socket) do
    case socket
         |> Phoenix.Token.verify("key", token) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}

      {:error, _error} ->
        :error
    end
  end

  def id(_socket), do: nil
end
