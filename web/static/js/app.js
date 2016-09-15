import "phoenix_html"
import {Socket} from "phoenix"
import React    from "react"
import ReactDOM from "react-dom"
import Feud from "./components/feud.js"

if ($("#socket-app").length) {
  let socket = new Socket("/socket")
  let token  = $("#socket-app").data("identifier")

  socket.connect()
  let channel = socket.channel("game:" + $("#socket-app").data("game"), {token: token})

  ReactDOM.render(
    <Feud channel={channel} token={token}/>,
    document.getElementById("socket-app")
  )
}
