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
        <hr />
        <div>
          Give points to:
          <a href="#" className="btn btn-sm btn-default btn-dole" onClick={ (e) => this.dole_points(e, 1) }>
            Team 1
          </a>
          <a href="#" className="btn btn-sm btn-default btn-dole" onClick={ (e) => this.dole_points(e, 2) }>
            Team 2
          </a>
        </div>
      </div>
    )
  },

  rebuttal() {
    return (
      <div className="well">
        Rebuttal Time
      </div>
    )
  },

  dole_points(e, team) {
    e.preventDefault()
    this.props.channel.push("act", { action: "dole_points", team: team })
  },
})

export default Actions
