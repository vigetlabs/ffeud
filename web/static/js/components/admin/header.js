import React from "react"

let Header = React.createClass({
  componentDidUpdate() {
    let { team_1_name, team_2_name, team_1_score, team_2_score, round_info } = this.props

    $("#team_1_name_input").val(team_1_name)
    $("#team_2_name_input").val(team_2_name)
    $("#team_1_input").val(team_1_score)
    $("#team_2_input").val(team_2_score)
    $("#multiplier_input").val(round_info.multiplier)
  },

  render() {
    let { team_1_name, team_2_name, team_1_score, team_2_score, round_info } = this.props
    let { pot, multiplier } = round_info

    return (
      <div className="well">
        <div>
          Team 1 Name: { team_1_name }
          <span className="left-padded">
            <a id="team_1_name_edit_link" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_1_name") }>
              Edit
            </a>
            <form id="team_1_name_form" style={{display: "none", marginBottom: 0}}>
              <input className="form-control" id="team_1_name_input" style={{width: "120px"}}/>
              <button className="btn btn-sm" onClick={ (e) => this.submit_edit_field(e, "team_1_name") }>Update</button>
              <a className="btn btn-sm btn-default" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_1_name") }>Cancel</a>
            </form>
          </span>
        </div>
        <div>
          Team 2 Name: { team_2_name }
          <span className="left-padded">
            <a id="team_2_name_edit_link" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_2_name") }>
              Edit
            </a>
            <form id="team_2_name_form" style={{display: "none", marginBottom: 0}}>
              <input className="form-control" id="team_2_name_input" style={{width: "120px"}}/>
              <button className="btn btn-sm" onClick={ (e) => this.submit_edit_field(e, "team_2_name") }>Update</button>
              <a className="btn btn-sm btn-default" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_2_name") }>Cancel</a>
            </form>
          </span>
        </div>
        <div>
          Team 1 Score: { team_1_score }
          <span className="left-padded">
            <a id="team_1_edit_link" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_1") }>
              Edit
            </a>
            <form id="team_1_form" style={{display: "none", marginBottom: 0}}>
              <input className="form-control" id="team_1_input" style={{width: "120px"}}/>
              <button className="btn btn-sm" onClick={ (e) => this.submit_edit_field(e, "team_1") }>Update</button>
              <a className="btn btn-sm btn-default" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_1") }>Cancel</a>
            </form>
          </span>
        </div>
        <div>
          Team 2 Score: { team_2_score }
          <span className="left-padded">
            <a id="team_2_edit_link" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_2") }>
              Edit
            </a>
            <form id="team_2_form" style={{display: "none", marginBottom: 0}}>
              <input className="form-control" id="team_2_input" style={{width: "120px"}}/>
              <button className="btn btn-sm" onClick={ (e) => this.submit_edit_field(e, "team_2") }>Update</button>
              <a className="btn btn-sm btn-default" href="#" onClick={ (e) => this.toggle_edit_field(e, "team_2") }>Cancel</a>
            </form>
          </span>
        </div>
        <div>
          Multiplier: { multiplier }
          <span className="left-padded">
            <a id="multiplier_edit_link" href="#" onClick={ (e) => this.toggle_edit_field(e, "multiplier") }>
              Edit
            </a>
            <form id="multiplier_form" style={{display: "none", marginBottom: 0}}>
              <input className="form-control" id="multiplier_input" style={{width: "120px"}}/>
              <button className="btn btn-sm" onClick={ (e) => this.submit_edit_field(e, "multiplier") }>Update</button>
              <a className="btn btn-sm btn-default" href="#" onClick={ (e) => this.toggle_edit_field(e, "multiplier") }>Cancel</a>
            </form>
          </span>
        </div>
        <div>
          Question: { round_info.question }
        </div>
      </div>
    )
  },

  toggle_edit_field(e, field) {
    e.preventDefault();

    $("#" + field + "_edit_link").toggle()
    $("#" + field + "_form").toggle()
  },

  submit_edit_field(e, field) {
    this.toggle_edit_field(e, field)

    let value = $("#" + field + "_input").val()
    this.props.channel.push("act", { action: "edit_data", field: field, value: value })
  }
})

export default Header
