# class StaticController < ApplicationController
class StaticController < ApplicationController
  def home
    # @posts = Post.all
    @posts = Post.page params[:page]

    respond_to do |format|
      format.html
      format.js
    end
  end
end
