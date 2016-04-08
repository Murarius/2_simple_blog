var Comments = React.createClass({
  getInitialState: function() {
    return {
      postId: this.props.postId,
      comments: this.props.comments,
      commentsCount: this.props.comments.length
    };
  },
  handleNewComment: function(comment) {
    var comments = this.state.comments;
    comments.push(comment);
    this.replaceState({comments: comments, commentsCount: comments.length});
  },
  render: function() {
    var self = this;
    return (
      <div className='comments'>
        <h2>Comments: <CommentsCount>{this.state.commentsCount}</CommentsCount></h2>
        <AddComment postId={this.state.postId} handleNewComment={self.handleNewComment}></AddComment>
        {this.state.comments.map(function(comment) {
          return (<Comment comment={comment} key={comment.id}></Comment>);
        })}
      </div>
    );
  }
});
