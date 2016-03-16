# class StaticController < ApplicationController
class StaticController < ApplicationController
  def home
    @posts = Post.order_by_created_at.from_year(params[:year]).page params[:page]
    @post_counts_by_year = Post.post_counts_by_year

    respond_to do |format|
      format.html
      format.js
    end
  end
end
