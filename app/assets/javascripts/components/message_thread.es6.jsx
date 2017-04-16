class MessageThread extends React.Component {
  render () {
    return (
      <div class='messageThread'>
        <ul>
          {this.props.messages.map(function(message, index){
            return <li><Message type={message.type} username={message.username}
                    body={message.body} link={message.link} /></li>
          })}
        </ul>
      </div>
    );
  }
}

MessageThread.propTypes = {
  messages: React.PropTypes.array
};
