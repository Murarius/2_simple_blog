var AddComment = React.createClass({
  propTypes: {
    postId: React.PropTypes.number,
    handleNewComment: React.PropTypes.func,
    handleNewCommentError: React.PropTypes.func
  },
  _newCommentData: function() {
    return ({post_id: this.props.postId,
             author: this.refs.author.value,
             content: this.refs.content.value});
  },
  _addComment: function(e) {
    var self = this;
    var comment = this._newCommentData();
    e.preventDefault();
    $.ajax({
     type: "POST",
     url: '/comments',
     data: { comment: comment },
     dataType: 'JSON',
     success: function(comment) {
       self._clearCommentForm();
       self.props.handleNewComment(comment);
     },
     error: function(commentErrors) {
       self.props.handleNewCommentError(commentErrors);
     }
   });
  },
  _clearCommentForm: function() {
    this.refs.author.value = null;
    this.refs.content.value = null;
  },
  render: function() {
    return (
      <div className='add-comment'>
        <div className='new-author'>
          <span>Author: </span><input id='input-author' ref='author'></input>
        </div>
        <textarea id='input-content' ref='content' rows='4'></textarea>
        <a href='#' onClick={this._addComment} className='button'>Add Comment</a>
      </div>
    );
  }
});
