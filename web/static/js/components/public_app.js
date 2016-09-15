import React     from "react"

let PublicApp = React.createClass({
  componentDidMount() {
    this.props.channel.on("state", payload => {
      console.log(payload)
    })

    this.props.channel.join()
      .receive("ok", resp => { console.log("Public join success", resp) })
      .receive("error", resp => { console.log("Public join fail", resp) })
  },

  render() {
    return (
      <div>
      </div>
    )
  }
})

export default PublicApp
