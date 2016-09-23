import React  from "react"

let FastMoney = React.createClass({
  load_answers() {
    let { answers, points } = this.props.round_info
    let indeces = [0,1,2,3,4]
    indeces.map(function(index) {
      $("#answer-" + index).val(answers[index])
      $("#point-" + index).val(points[index])
    })
  },

  componentDidMount() {
    this.load_answers()
  },

  componentDidUpdate() {
    this.load_answers()
  },

  render() {
    return (
      <div className="well">
        <h4>Fast Money</h4>

        <div style={{marginTop: "10px"}}>
          <b>Notes:</b>
        </div>
        <div style={{whiteSpace: "pre-wrap"}}>
          {this.props.round_info.notes}
        </div>

        <div className="fast-money-inputs">
          <div className="fm-answers">
            {[0,1,2,3,4].map(this.render_answers)}
          </div>
          <div className="fm-points">
            {[0,1,2,3,4].map(this.render_points)}
          </div>
          <div className="fm-show-actions">
            {[0,1,2,3,4].map(this.render_actions)}
          </div>
        </div>
      </div>
    )
  },

  render_answers(index) {
    return (
      <input key={index} id={"answer-" + index} onBlur={(e) => this.handleAnswer(e, index)} placeholder={"Answer " + (index + 1)} className="fm-answer"/>
    )
  },

  render_points(index) {
    return (
      <input key={index} id={"point-" + index} onBlur={(e) => this.handlePoint(e, index)} type="number" className="fm-points"/>
    )
  },

  handleAnswer(e, index) {
    let value = e.target.value;
    this.props.channel.push("silent_act", {
      action: "fm_store",
      type:   "answer",
      index:  index,
      value:  value}
    )
  },

  handlePoint(e, index) {
    let value = e.target.value;
    this.props.channel.push("silent_act", {
      action: "fm_store",
      type:   "point",
      index:  index,
      value:  value}
    )
  },

  render_actions(index) {
    let {answer_state, point_state} = this.props.round_info

    return (
      <div key={index}>
        <button
          onClick={() => this.showAnswer(index)}
          className="answer-button"
          disabled={answer_state[index]}>
          Show Answer
        </button>
        <button
          onClick={() => this.showPoints(index)}
          className="points-button"
          disabled={point_state[index]}>
          Show Points
        </button>
      </div>
    )
  },

  showAnswer(index) {
    this.props.channel.push("act", {
      action: "fm_show",
      type:   "answer",
      index:  index}
    )
  },

  showPoints(index) {
    this.props.channel.push("act", {
      action: "fm_show",
      type:   "point",
      index:  index}
    )
  },
})

export default FastMoney
