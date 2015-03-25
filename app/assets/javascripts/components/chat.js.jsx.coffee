window.App = {}

$ ->
  App.Chat.setState catface: true

window.Chat = React.createClass
  onMemberNameChange: (e) ->
    @setState name: e.target.value
  onTextChange: (e) ->
    @setState text: e.target.value
  fetchMessage: ->
    $.ajax(
      url: "/messages"
      dataType: 'JSON'
      method: 'GET'
    ).done (data) =>
      @setState messages: data
  getInitialState: ->
    App.Chat = @
    @fetchMessage()
    {text: '', name: 'Billy', messages: []}
  onSubmit: ->
    newMessage =
      text: @state.text
      name: @state.name
    @setState messages: @state.messages.concat([newMessage])
    $.ajax
      url: "/messages"
      data: {message: newMessage}
      dataType: 'JSON'
      method: 'POST'
  render: ->
    name = JSON.parse(@props.meta).title
    styles =
      color: 'green'
      border: '12px solid red'
    `<div>
      <h1>{name}</h1>
      <div>
        <MessageList messages={this.state.messages} />
      </div>
      <div id="gray-bg" style={styles}>
        your name: <input value={this.state.name} onChange={this.onMemberNameChange} />
        your message: <input value={this.state.text} onChange={this.onTextChange} />
        <button onClick={this.onSubmit}>Send it</button>
      </div>
      <button type="button" className="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
        Launch demo modal
      </button>
    </div>`