# class CommentsController < ApplicationController
class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: 200
    else
      render json: comment.errors, status: 422
    end
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit([:author, :content, :post_id])
  end
end
