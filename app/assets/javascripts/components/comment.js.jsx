var Comment = React.createClass({
  propTypes: {
    comment: React.PropTypes.object,
  },
  render: function() {
    return (
      <div className='comment'>
        <div className='comment-header'>
          <div className='comment-author'>{this.props.comment.author}</div>
          <div className='comment-created-at'>{this.props.comment.created_at}</div>
        </div>
        <div className='comment-content'>{this.props.comment.content}</div>
      </div>
    );
  }
});
