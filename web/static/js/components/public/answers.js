import React from "react"

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
    let answers = this.props.round_info.answers

    return [0,1,2,3,4,5].map(function(index) {
      let answer = answers[index]

      if (answer && answer.used) {
        return (
          <li className="answer used" key={ index }>
            { answer.body } ({ answer.points })
          </li>
        )
      } else {
        let class_name = "answer unused exists-" + (answer !== undefined)
        return (
          <li className={ class_name } key={ index }>
            { index + 1 }
          </li>
        )
      }
    })
  }
})

export default Answers
