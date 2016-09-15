import React from "react"

let Actions = React.createClass({
  render() {
    let { done, rebuttal } = this.props.round_info

    if (done) {
      return this.done()
    } else if (rebuttal) {
      return this.rebuttal()
    } else {
      return null
    }
  },

  done() {
    return (
      <div className="well">
        Round Over
      </div>
    )
  },

  rebuttal() {
    return (
      <div className="well">
        Rebuttal Time
      </div>
    )
  }
})

export default Actions
