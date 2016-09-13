import React from "react"

let Message = React.createClass({
  render() {
    var {time, body} = this.props

    return (
      <li>
        [{time}] {body}
      </li>
    )
  }
})

export default Message
