# class CommentsController < ApplicationController
class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: 200
    else
      render json: comment.errors, status: 422
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    render nothing: true, status: 204
  end

  private

  def comment_params
    params.require(:comment).permit([:author, :content, :post_id])
  end
end
