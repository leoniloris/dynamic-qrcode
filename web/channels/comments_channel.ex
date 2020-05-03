defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  # def join(topic, auth_msg, arg2) do
  def join(name, msg, socket) do
    {:ok, %{:aye => "babay"}, socket}
  end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end
end
