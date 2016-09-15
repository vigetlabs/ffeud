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
    let answers     = this.props.round_info.answers
    let { channel } = this.props

    return [0,1,2,3,4,5].map(function(index) {
      let answer = answers[index]

      if (answer) {
        return (
          <li className="answer exists-true" key={ index }>
            <Answer channel={ channel } answer={ answer } index={ index } />
          </li>
        )
      } else {
        return (
          <li className="answer exists-false" key={ index }>
            { index + 1 }
          </li>
        )
      }
    }.bind(this))
  }
})

export default Answers
