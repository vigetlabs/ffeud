import React from "react"

let Strikes = React.createClass({
  render() {
    return (
      <div className="well">
        <div className={ this.class_for(1) }>
          X
        </div>
        <div className={ this.class_for(2) }>
          X
        </div>
        <div className={ this.class_for(3) }>
          X
        </div>
      </div>
    )
  },

  class_for(i) {
    return i <= this.props.round_info.x_count ? "on" : "off"
  }
})

export default Strikes
