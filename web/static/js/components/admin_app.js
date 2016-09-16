import React   from "react"
import Header  from "./admin/header.js"
import Answers from "./admin/answers.js"
import Strikes from "./admin/strikes.js"
import Actions from "./admin/actions.js"

let AdminApp = React.createClass({
  getInitialState() {
    return {
      team_1_score: 0,
      team_2_score: 0,
      round_info: {
        pot:        0,
        question:   "",
        x_count:    0,
        answers:    [],
        rebuttal:   false,
        done:       false,
        last_round: false
      }
    }
  },

  componentDidMount() {
    this.props.channel.on("state", payload => {
      this.setState(payload)
      console.log(payload)
    })

    this.props.channel.join()
      .receive("ok", resp => {
        console.log("Admin join success", resp)
        this.props.channel.push("load_state")
      })
      .receive("error", resp => { console.log("Admin join fail", resp) })
  },

  render() {
    return (
      <div>
        <Header  channel={ this.props.channel } { ...this.state } />
        <Answers channel={ this.props.channel } { ...this.state } />
        <Strikes channel={ this.props.channel } { ...this.state } />
        <Actions channel={ this.props.channel } { ...this.state } />
      </div>
    )
  }
})

export default AdminApp
