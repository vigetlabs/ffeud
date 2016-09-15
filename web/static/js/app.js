import "phoenix_html"
import {Socket} from "phoenix"
import React    from "react"
import ReactDOM from "react-dom"
import Messages from "./components/messages.js"

if ($("#socket-app").length) {
  let socket = new Socket("/socket")
  socket.connect()
  let channel = socket.channel("game:" + $("#socket-app").data("game"), {token: $("#socket-app").data("identifier")})

  ReactDOM.render(
    <Messages channel={channel}/>,
    document.getElementById("socket-app")
  )
}
