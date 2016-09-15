import React   from "react"
import Header  from "./public/header.js"
import Answers from "./public/answers.js"
import Strikes from "./public/strikes.js"

let PublicApp = React.createClass({
  getInitialState() {
    return {
      team_1_score: 0,
      team_2_score: 0,
      pot: 0,
      round_info: {
        question: "",
        x_count:  0,
        answers:  []
      }
    }
  },

  componentDidMount() {
    this.props.channel.on("state", payload => {
      console.log(payload)
      this.setState(payload)
    })

    this.props.channel.join()
      .receive("ok", resp => {
        console.log("Public join success", resp)
        this.props.channel.push("update_state")
      })
      .receive("error", resp => { console.log("Public join fail", resp) })
  },

  render() {
    return (
      <div>
        <Header  { ...this.state } />
        <Answers { ...this.state } />
        <Strikes { ...this.state } />
      </div>
    )
  }
})

export default PublicApp
