import React  from "react"

let Answer = React.createClass({
  render() {
    let { answer, index } = this.props

    if (answer.used) {
      return (
        <span>
          { answer.body } ({ answer.points })
        </span>
      )
    } else {
      return (
        <span>
          { answer.body } ({ answer.points }) <a href="#" onClick={ (e) => this.use_answer(e, index) }>Use</a>
        </span>
      )
    }
  },

  use_answer(e, index) {
    e.preventDefault()
    this.props.channel.push("act", { action: "use_answer", index: index })
  }
})

export default Answer
