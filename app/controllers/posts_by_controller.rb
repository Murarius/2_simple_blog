# class PostsByController < ApplicationController
class PostsByController < ApplicationController
  def year_posts_months_counts
    @year = params[:year]
    @posts_counts_in_months = Post.post_counts_by_month(@year)
    render :year_give_months_counts, layout: nil
  end
end
