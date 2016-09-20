import React from "react"

let Header = React.createClass({
  render() {
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
        <div className="question">
          { round_info.question }
        </div>
      </div>
    )
  },

  render_pot() {
    let { pot } = this.props.round_info
    return (
      <div className="pot">
        { pot }
      </div>
    )
  },

  render_multiplier() {
    let { multiplier } = this.props.round_info
    if (multiplier > 1) {
      return (
        <div className="multiplier">
          x{ multiplier }
        </div>
      )
    } else {
      return null
    }
  }
})

export default Header
