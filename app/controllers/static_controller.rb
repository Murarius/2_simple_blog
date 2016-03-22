# class StaticController < ApplicationController
class StaticController < ApplicationController
  def home
    @posts = Post.load_to_home(params[:year], params[:month], params[:page])
    @post_counts_by_year = Post.counts_by_years
    @new_posts = Post.new_posts

    respond_to do |format|
      format.html
      format.js
    end
  end
end
