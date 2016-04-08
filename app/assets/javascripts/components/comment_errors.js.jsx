var CommentErrors = React.createClass({
  propTypes: {
    commentErrors: React.PropTypes.object
  },
  render: function() {
    var errors = this.props.commentErrors;
    if (this.props.commentErrors != null) {
      return (<div className='errors'>
                <h2>Errors</h2>
                <ul>
                  { Object.keys(errors).map(function(key, index) {
                    return (<li key={index}>{key} {errors[key]}</li>);
                  })}
                </ul>
              </div>);
    }
    else {
      return (<div></div>);
    }
  }
});
