var CommentsCount = React.createClass({
  propTypes: {
    commentsCount: React.PropTypes.number,
  },
  render: function() {
    return (<span>{this.props.commentsCount}</span>);
  }
});
