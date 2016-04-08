var Comments = React.createClass({
  getInitialState: function() {
    return {
      postId: this.props.postId,
      comments: this.props.comments,
      commentsCount: this.props.comments.length,
      commentErrors: null
    };
  },
  handleNewCommentError: function(errors) {
    this.setState({commentErrors: JSON.parse(errors.responseText)})
  },
  handleNewComment: function(comment) {
    var comments = this.state.comments;
    comments.push(comment);
    this.setState({comments: comments, commentsCount: comments.length, commentErrors: null});
  },
  render: function() {
    var self = this;
    return (
      <div className='comments'>
        <h2>Comments: <CommentsCount>{this.state.commentsCount}</CommentsCount></h2>
        <CommentErrors commentErrors={this.state.commentErrors}></CommentErrors>
        <AddComment postId={this.state.postId}
                    handleNewComment={this.handleNewComment}
                    handleNewCommentError={this.handleNewCommentError}></AddComment>
        {this.state.comments.map(function(comment) {
          return (<Comment comment={comment} key={comment.id}></Comment>);
        })}
      </div>
    );
  }
});
