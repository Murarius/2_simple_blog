var Comments = React.createClass({
  propTypes: {
    postId: React.PropTypes.number,
    comments: React.PropTypes.array,
    commentErrors: React.PropTypes.object
  },
  getInitialState: function() {
    return {
      postId: this.props.postId,
      comments: this.props.comments,
      commentsCount: this.props.comments.length,
      commentErrors: null
    };
  },
  _handleNewCommentError: function(errors) {
    this.setState({commentErrors: JSON.parse(errors.responseText)})
  },
  _handleNewComment: function(comment) {
    var comments = this.state.comments;
    comments.push(comment);
    this.setState({comments: comments, commentsCount: comments.length, commentErrors: null});
  },
  render: function() {
    var self = this;
    return (
      <div className='comments'>
        <h2>Comments: <CommentsCount commentsCount={this.state.commentsCount}></CommentsCount></h2>
        <CommentErrors commentErrors={this.state.commentErrors}></CommentErrors>
        <AddComment postId={this.state.postId}
                    handleNewComment={this._handleNewComment}
                    handleNewCommentError={this._handleNewCommentError}></AddComment>
        {this.state.comments.map(function(comment) {
          return (<Comment comment={comment} key={comment.id}></Comment>);
        })}
      </div>
    );
  }
});
