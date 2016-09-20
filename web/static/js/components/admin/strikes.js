import React from "react"

let Strikes = React.createClass({
  render() {
    return (
      <div className="well strikes admin">
        <div style={{marginBottom: "45px"}}>
          <b>Team 1: </b>
          { this.strike_for(1, 1) }
          { this.strike_for(2, 1) }
          { this.strike_for(3, 1) }
        </div>

        <b>Team 2: </b>
        { this.strike_for(1, 2) }
        { this.strike_for(2, 2) }
        { this.strike_for(3, 2) }
      </div>
    )
  },

  strike_for(i, team) {
    if (this.next_strike_for(i, team)) {
      return (
        <a href="#" onClick={ (e) => this.add_strike(e, team) } className={ this.class_for(i, team) }>
          X
        </a>
      )
    } else {
      return (
        <div className={ this.class_for(i, team) }>
          X
        </div>
      )
    }
  },

  add_strike(e, team) {
    e.preventDefault()
    this.props.channel.push("act", { action: "add_strike", team: team })
  },

  class_for(i, team) {
    let class_name = "strike"
    class_name += this.on_for(i, team) ? " strike-on" : " strike-off"
    if (this.next_strike_for(i, team)) {
      class_name += " strike-link"
    }

    return class_name
  },

  on_for(i, team) {
    let count = team == 1 ? this.props.round_info.team_1_x_count : this.props.round_info.team_2_x_count
    return i <= count
  },

  next_strike_for(i, team) {
    let count = team == 1 ? this.props.round_info.team_1_x_count : this.props.round_info.team_2_x_count
    return i == count + 1
  }
})

export default Strikes
