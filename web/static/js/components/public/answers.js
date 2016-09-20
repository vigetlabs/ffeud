import React from "react"

let Answers = React.createClass({
  render() {
    let answers = this.props.round_info.answers

    return (
      <div className="answers public">
        <div className="answer-column">
          { [0,1,2,3,4].map(this.render_answer) }
        </div>
      </div>
    )
  },

  render_answer(index) {
    let answer = this.props.round_info.answers[index]

    if (answer && answer.used) {
      return (
        <div className="answer used" key={ index }>
          <div className="answer-body">
            { answer.body }
          </div>
          <div className="answer-points">
            { answer.points }
          </div>
        </div>
      )
    } else {
      return (
        <div className="answer unused" key={ index }>
          <div className="answer-empty">
            { answer !== undefined ? index + 1 : "\u00a0" }
          </div>
        </div>
      )
    }
  }
})

export default Answers
