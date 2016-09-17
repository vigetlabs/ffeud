import React from "react"

let Strikes = React.createClass({
  render() {
    let { rebuttal } = this.props.round_info

    return (
      <div className="well strikes admin">
        { this.strike_for(1) }
        { this.strike_for(2) }
        { this.strike_for(3) }
        { rebuttal ? this.rebuttal_strike() : null }
      </div>
    )
  },

  strike_for(i) {
    if (this.next_strike_for(i)) {
      return (
        <a href="#" onClick={ this.add_strike } className={ this.class_for(i) }>
          X
        </a>
      )
    } else {
      return (
        <div className={ this.class_for(i) }>
          X
        </div>
      )
    }
  },

  rebuttal_strike() {
    return (
      <span>
        + <a href="#" onClick={ this.add_strike } className="strike strike-link">
          X
        </a>
      </span>

    )
  },

  add_strike(e) {
    e.preventDefault()
    this.props.channel.push("act", { action: "add_strike" })
  },

  class_for(i) {
    let class_name = "strike"
    class_name += this.on_for(i) ? " strike-on" : " strike-off"
    if (this.next_strike_for(i)) {
      class_name += " strike-link"
    }

    return class_name
  },

  on_for(i) {
    return i <= this.props.round_info.x_count
  },

  next_strike_for(i) {
    return i == this.props.round_info.x_count + 1
  }
})

export default Strikes
