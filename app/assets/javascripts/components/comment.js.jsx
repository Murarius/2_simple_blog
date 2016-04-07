var Comment = React.createClass({
  getInitialState: function() {
    return {
      comment: this.props.comment
    };
  },
  render: function() {
    return (
      <div className='comment'>
        <div className='comment-header'>
          <div className='comment-author'>{this.state.comment.author}</div>
          <div className='comment-created_at'>{this.state.comment.created_at}</div>
        </div>
        <div className='comment-content'>{this.state.comment.content}</div>
        <div className='comment-comments-bar'>add comment</div>
      </div>
    );
  }
});
