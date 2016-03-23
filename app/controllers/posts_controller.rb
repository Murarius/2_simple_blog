# class PostsController < ApplicationController
class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @sidebar = load_sidebar
  end

  def new
    @post = Post.new
    @sidebar = load_sidebar
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path, notice: 'Post created.'
    else
      @sidebar = load_sidebar
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @sidebar = load_sidebar
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: 'Post updated.'
    else
      @sidebar = load_sidebar
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).delete
    redirect_to root_path, notice: 'Post deleted.'
  end

  private

  def post_params
    params.require(:post).permit([:title, :content, :more_content])
  end
end
