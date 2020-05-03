import { Socket } from "phoenix"

let socket = new Socket("/socket", { params: { token: window.userToken } })

socket.connect()

const createSocket = (topicId) => {
  let channel = socket.channel(`comments_for_topic:${topicId}`, {})
  channel.join()
    .receive("ok", resp => {
      renderComments(resp.comments)
      console.log(resp)
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on(`comments_for_topic:${topicId}:new`, renderComment);

  document.querySelector("button").addEventListener("click", () => {
    const content = document.querySelector("textarea").value;
    channel.push("comments_for_topic:add", { content: content })
  })
}

function renderComments(commentsEvent) {
  const renderedComments = commentsEvent.map(commentEvent => {
    return buildCommentTemplate(commentEvent);
  });
  document.querySelector(".collection").innerHTML = renderedComments.join("");
}

function renderComment(commentEvent) {
  document.querySelector(".collection").innerHTML += buildCommentTemplate(commentEvent.comment);
}

function buildCommentTemplate(commentEvent) {
  let email = "";
  if (commentEvent.user) {
    email = commentEvent.user.email;
  }
  return `
  <li class="collection-item">
    ${commentEvent.content}
    <div class="secondary-content">
      ${email}
    </div>
  </li>
`;
}

window.createSocket = createSocket;
