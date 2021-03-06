# class sidebar
class Sidebar
  attr_accessor :new_posts
  attr_accessor :popular_posts
  attr_accessor :posts_counts_by_years

  def initialize(new_posts = nil, posts_counts_by_years = nil, popular_posts = nil)
    @new_posts = new_posts || load_new_posts
    @posts_counts_by_years = posts_counts_by_years || load_posts_counts_by_years
    @popular_posts = popular_posts || load_popular_posts
  end

  def self.new_from_cookie(cookie)
    sidebar_cookie = JSON.parse(cookie, symbolize_names: true)
    new(sidebar_cookie[:new_posts], sidebar_cookie[:posts_counts_by_years])
  end

  private

  def load_new_posts
    @new_posts = Post.new_posts
  end

  def load_popular_posts
    # to do ...
  end

  def load_posts_counts_by_years
    Post.counts_by_years
  end
end
