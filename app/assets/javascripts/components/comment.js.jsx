var Comment = React.createClass({
  propTypes: {
    comment: React.PropTypes.object,
    loggedIn: React.PropTypes.bool,
    handleDelete: React.PropTypes.func
  },
  _delete: function(e) {
    var self = this;
    e.preventDefault();
    $.ajax({
      type: "DELETE",
      url: '/comments/' + self.props.comment.id,
      dataType: 'JSON',
      success: function(note) {
        self.props.handleDelete(self.props.comment);
      }
    });
  },
  render: function() {
    var deleteButton;
    if (this.props.loggedIn) {deleteButton = <a onClick={this._delete} className='delete-comment fa fa-times'/>}
    return (
      <div className='comment'>
        <div className='comment-header'>
          <div className='comment-author'>{this.props.comment.author}</div>
          <div className='comment-created-at'>created: {this.props.comment.created_at}</div>
          {deleteButton}
        </div>
        <div className='comment-content'>{this.props.comment.content}</div>
      </div>
    );
  }
});
