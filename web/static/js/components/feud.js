import React     from "react"
import AdminApp  from "./admin_app"
import PublicApp from "./public_app"

let Feud = React.createClass({
  render() {
    let { token, channel } = this.props

    let App = token == "admin" ? AdminApp : PublicApp
    return (<App channel={channel} />)
  }
})

export default Feud
