window.Message = React.createClass
  yo: ->
    alert "Yo"
  render: ->
    `<div><strong onClick={this.yo}>{this.props.name}:</strong> {this.props.text}</div>`
