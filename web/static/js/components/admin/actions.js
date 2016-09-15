import React from "react"

let Actions = React.createClass({
  render() {
    let { done, rebuttal }  = this.props.round_info

    if (done) {
      return this.done()
    } else if (rebuttal) {
      return this.rebuttal()
    } else {
      return null
    }
  },

  done() {
    let { pot } = this.props

    return (
      <div className="well">
        Round Over
        <hr />
        { pot > 0 ? this.dole_points_prompt() : this.next_round_prompt() }
      </div>
    )
  },

  dole_points_prompt() {
    return (
      <div>
        Give points to:
        <a href="#" className="btn btn-sm btn-default btn-spacious" onClick={ (e) => this.dole_points(e, 1) }>
          Team 1
        </a>
        <a href="#" className="btn btn-sm btn-default btn-spacious" onClick={ (e) => this.dole_points(e, 2) }>
          Team 2
        </a>
      </div>
    )
  },

  next_round_prompt() {
    return (
      <div>
        Ready for the next round?
        <a href="#" className="btn btn-sm btn-success btn-spacious" onClick={ this.next_round }>
          Next Round
        </a>
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

  next_round(e) {
    e.preventDefault()
    this.props.channel.push("act", { action: "next_round" })
  }
})

export default Actions
