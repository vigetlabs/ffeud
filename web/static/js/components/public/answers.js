import React from "react"

let Answers = React.createClass({
  render() {
    let answers = this.props.round_info.answers

    return (
      <div className="answers public">
        { this.render_left_column() }
        { answers.length > 4 ? this.render_right_column() : null }
      </div>
    )
  },

  render_left_column() {
    let answers    = this.props.round_info.answers
    let class_name = "answer-column column-" + (answers.length > 4 ? "normal" : "wide")

    return (
      <div className={ class_name }>
        { this.render_left_answers() }
      </div>
    )
  },

  render_right_column() {
    return (
      <div className="answer-column">
        { this.render_right_answers() }
      </div>
    )
  },

  render_left_answers() {
    return [0,1,2,3].map(function(index) {
      return this.render_answer(index)
    }.bind(this))
  },

  render_right_answers() {
    return [4,5,6,7].map(function(index) {
      return this.render_answer(index)
    }.bind(this))
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
