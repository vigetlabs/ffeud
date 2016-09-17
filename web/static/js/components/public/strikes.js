import React from "react"

let Strikes = React.createClass({
  render() {
    return (
      <div className="strikes public">
        <div className={ this.class_for(1) }>
          <div className="strike-x">X</div>
        </div>
        <div className={ this.class_for(2) }>
          <div className="strike-x">X</div>
        </div>
        <div className={ this.class_for(3) }>
          <div className="strike-x">X</div>
        </div>
      </div>
    )
  },

  class_for(i) {
    let on_off = i <= this.props.round_info.x_count ? "on" : "off"

    return "strike strike-" + on_off
  }
})

export default Strikes
