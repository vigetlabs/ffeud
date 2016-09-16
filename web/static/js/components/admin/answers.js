import React  from "react"
import Answer from "./answer.js"

let Answers = React.createClass({
  render() {
    return (
      <div className="well">
        <b>Answers:</b>
        <ul className="answers">
          { this.render_answers() }
        </ul>
      </div>
    )
  },

  render_answers() {
    let { round_info, channel } = this.props
    let answers = round_info.answers

    return answers.map(function(answer, index) {
      return (
        <li className={ this.class_name(answer) } key={ index }>
          <Answer channel={ channel } answer={ answer } index={ index } done={ round_info.done } />
        </li>
      )
    }.bind(this))
  },

  class_name(answer) {
    return "answer answer-" + (answer.used ? "used" : "unused")
  },
})

export default Answers
