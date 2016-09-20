import React from "react"

let Answer = React.createClass({
  render() {
    let { answer, index, done } = this.props

    if (answer.used) {
      return (
        <div>
          { answer.body } ({ answer.points })
        </div>
      )
    } else if (done) {
      return (
        <div>
          { answer.body } ({ answer.points }) <button className="btn btn-sm" onClick={ () => this.reveal_answer(index) }>Reveal</button>
        </div>
      )
    } else {
      return (
        <div>
          { answer.body } ({ answer.points }) <button className="btn btn-sm" onClick={ () => this.use_answer(index, 1) }>Team 1</button> <button className="btn btn-sm" onClick={ () => this.use_answer(index, 2) }>Team 2</button>
        </div>
      )
    }
  },

  use_answer(index, team) {
    this.props.channel.push("act", { action: "use_answer", index: index, team: team })
  },

  reveal_answer(index) {
    this.props.channel.push("act", { action: "reveal_answer", index: index })
  }
})

export default Answer
