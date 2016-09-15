import React from "react"

let Strikes = React.createClass({
  render() {
    return (
      <div className="well">
        { this.strike_for(1) }
        { this.strike_for(2) }
        { this.strike_for(3) }
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
