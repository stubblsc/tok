class Message extends React.Component {
  render () {
    return (
      <div>
        <div class='messageHeader'>
          <h3>
            {this.props.username}
          </h3>
        </div>
        <div class='messageBody'>
          <p class='messageContent'>
            if(this.isTopic()){
              <a href={this.props.link}>{this.props.body}</a>
            }else{
              {this.props.body}
            }
        </div>
      </div>
    );
  }

  isTopic(){
    return true if this.props.type == 'topic'

    return false
  }
}

Message.propTypes = {
  type: React.PropTypes.string,
  username: React.PropTypes.string,
  body: React.PropTypes.string,
  link: React.PropTypes.string
};
