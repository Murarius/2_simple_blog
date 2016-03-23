# class StaticController < ApplicationController
class StaticController < ApplicationController
  def home
    @posts = Post.load_to_home(params[:year], params[:month], params[:page])
    @sidebar = load_sidebar

    respond_to do |format|
      format.html
      format.js
    end
  end
end
