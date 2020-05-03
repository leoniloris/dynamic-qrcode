defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.{Topic, Comment}

  @channel_topic "comments_for_topic:"

  # def join(topic, auth_msg, arg2) do
  def join(@channel_topic <> topic_id_str, _msg, socket) do
    topic_id = String.to_integer(topic_id_str)

    topic =
      Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => comment_from_page}, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    changeset =
      topic
      |> build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(%{content: comment_from_page})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(
          socket,
          @channel_topic <> "#{socket.assigns.topic.id}:new",
          %{comment: comment}
        )

        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
