import React from "react"

let Actions = React.createClass({
  render() {
    let { rebuttal } = this.props.round_info

    return (
      <div className="well">
        Rebuttal: { rebuttal ? "True" : "False" }
      </div>
    )
  }
})

export default Actions
