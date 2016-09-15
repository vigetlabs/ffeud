import React from "react"

let Header = React.createClass({
  render() {
    let { team_1_score, team_2_score, pot, round_info } = this.props

    return (
      <div className="well">
        <div>
          Team 1: { team_1_score }
        </div>
        <div>
          Team 2: { team_2_score }
        </div>
        <div>
          Pot: { pot }
        </div>
        <div>
          Question: { round_info.question }
        </div>
      </div>
    )
  }
})

export default Header
