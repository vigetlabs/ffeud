import React   from "react"
import Message from "./message.js"

let Messages = React.createClass({
  getInitialState() {
    return {
      messages: []
    }
  },

  componentDidMount() {
    let chatInput = $("#chat-input")

    chatInput.on("keypress", event => {
      if (event.keyCode === 13) {
        this.props.channel.push("new_msg", {body: chatInput.val()})
        chatInput.val("")
      }
    })

    this.props.channel.on("new_msg", payload => {
      this.setState({
        messages: this.state.messages.concat({
          time: Date(),
          body: payload.body
        })
      })
    })

    this.props.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
  },

  render() {
    return (
      <ul>
        {
          this.state.messages.map(obj => {
            return <Message { ...obj } key={ obj.time } />
          })
        }
      </ul>
    )
  }
})

export default Messages
