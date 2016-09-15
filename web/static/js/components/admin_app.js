import React     from "react"

let AdminApp = React.createClass({
  componentDidMount() {
    let reload = $("#reload-state")

    reload.on("click", event => {
      this.props.channel.push("update_state")
    })

    this.props.channel.on("state", payload => {
      console.log(payload)
    })

    this.props.channel.join()
      .receive("ok", resp => {
        console.log("Admin join success", resp)
        this.props.channel.push("update_state")
      })
      .receive("error", resp => { console.log("Admin join fail", resp) })
  },

  render() {
    return (
      <div>
      </div>
    )
  }
})

export default AdminApp
