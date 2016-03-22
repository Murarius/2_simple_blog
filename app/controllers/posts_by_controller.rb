# class PostsByController < ApplicationController
class PostsByController < ApplicationController
  def year_posts_months_counts
    @year = params[:year]
    @posts_counts_in_months = Post.counts_by_months(@year)
    render :year_give_months_counts, layout: nil
  end
end
