// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("game:lobby", {})

let chatInput         = $("#chat-input")
let messagesContainer = $("#messages")

chatInput.on("keypress", event => {
  if (event.keyCode === 13) {
    console.log("send")
    channel.push("new_msg", {body: chatInput.val()})
    chatInput.val("")
  }
})

channel.on("new_msg", payload => {
  console.log("receive")
  messagesContainer.append(`<br>[${Date()}] ${payload.body}`)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
