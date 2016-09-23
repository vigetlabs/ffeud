// TODO: Add team strikes

import React from "react"

let Header = React.createClass({
  render() {
    if (this.props.round_type == "regular") {
      return this.render_header()
    } else {
      return this.render_fast_money_header()
    }
  },

  render_header() {
    let { team_1_name, team_2_name, team_1_score, team_2_score, round_info } = this.props

    return (
      <div>
        <div className="points-and-pot">
          <div className="team-left">
            <div className="team-name">
              { team_1_name }
            </div>
            <div className="team-score">
              { team_1_score }
            </div>
          </div>
          <div className="team-right">
            <div className="team-name">
              { team_2_name }
            </div>
            <div className="team-score">
              { team_2_score }
            </div>
          </div>
        </div>
        <div className="team-strikes">
          <div className="left-strikes">
            <div className={ this.strike_class_for(1, 1) }>
              <div className="strike-x">X</div>
            </div>
            <div className={ this.strike_class_for(2, 1) }>
              <div className="strike-x">X</div>
            </div>
            <div className={ this.strike_class_for(3, 1) }>
              <div className="strike-x">X</div>
            </div>
          </div>
          <div className="right-strikes">
            <div className={ this.strike_class_for(1, 2) }>
              <div className="strike-x">X</div>
            </div>
            <div className={ this.strike_class_for(2, 2) }>
              <div className="strike-x">X</div>
            </div>
            <div className={ this.strike_class_for(3, 2) }>
              <div className="strike-x">X</div>
            </div>
          </div>
        </div>
        <div className="question">
          { round_info.question }
        </div>
      </div>
    )
  },

  render_fast_money_header() {
    let { team_1_name, team_1_score } = this.props

    return (
      <div>
        <div className="team-center">
          <div className="team-name">
            { team_1_name }
          </div>
          <div className="team-score">
            { team_1_score }
          </div>
        </div>
      </div>
    )
  },

  strike_class_for(i, team) {
    let count = team == 1 ? this.props.round_info.team_1_x_count : this.props.round_info.team_2_x_count
    let on_off = i <= count ? "on" : "off"

    return "strike strike-" + on_off
  }
})

export default Header
