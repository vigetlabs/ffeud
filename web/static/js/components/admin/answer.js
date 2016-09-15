import React from "react"

let Answer = React.createClass({
  render() {
    let { answer, index, done } = this.props

    if (answer.used || done) {
      return (
        <div>
          { answer.body } ({ answer.points })
        </div>
      )
    } else {
      return (
        <div>
          { answer.body } ({ answer.points }) <a href="#" onClick={ (e) => this.use_answer(e, index) }>Use</a>
        </div>
      )
    }
  },

  use_answer(e, index) {
    e.preventDefault()
    this.props.channel.push("act", { action: "use_answer", index: index })
  }
})

export default Answer
