var Comments = React.createClass({
  getInitialState: function() {
    return {
      comments: this.props.comments
    };
  },
  render: function() {
    return (
      <div className='comments'>
        <h2>Comments:</h2>
        {this.state.comments.map(function(comment) {
          return (<Comment comment={comment} key={comment.id}></Comment>);
        })}
      </div>
    );
  }
});
