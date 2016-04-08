var AddComment = React.createClass({
  propTypes: {
    postId: React.PropTypes.number,
    handleNewComment: React.PropTypes.func
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
       console.log(comment);
       console.log(self.props);
       self.props.handleNewComment(comment);
     },
     error: function(commentErrors) {
       console.log(commentErrors);
       // incomplette !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     }
   });
  },
  render: function() {
    return (
      <div className='add-comment'>
        <div className='new-author'>
          <span>Author: </span><input ref='author'></input>
        </div>
        <textarea ref='content' rows='4'></textarea>
        <a onClick={this._addComment} className='button'>Add Comment</a>
      </div>
    );
  }
});
