# class Post < ActiveRecord::Base
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  before_save :reset_sidebar_token
  before_destroy :reset_sidebar_token

  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true

  @months = { 'January' => '01',
              'February' => '02',
              'March' => '03',
              'April' => '04',
              'May' => '05',
              'June' => '06',
              'July' => '07',
              'August' => '08',
              'September' => '09',
              'October' => '10',
              'November' => '11',
              'December' => '12' }

  scope :order_by_created_at, -> { order('created_at DESC') }
  scope :new_posts, -> { select('posts.id, posts.title, posts.created_at').order('posts.created_at DESC').limit(5) }
  scope :from_year, ->(year = nil) { where("to_char(posts.created_at, 'YYYY') = ?", year.to_s) if year }
  scope :from_month, ->(month = nil) { where("to_char(posts.created_at, 'MM') = ?", @months[month]) if month }

  scope :counts_by_years, -> do
    select("to_char(posts.created_at, 'YYYY') as year, count(*) as count")
      .group('year')
      .order('year DESC')
  end

  scope :counts_by_months, ->(year) do
    select("regexp_replace(to_char(posts.created_at, 'Month'), '\s+$', '') as month,
            to_char(posts.created_at, 'MM') as month_number, count(*) as count")
      .where("to_char(posts.created_at, 'YYYY') = ?", year.to_s)
      .group('month, month_number')
      .order('month_number')
  end

  def self.load_to_home(year = nil, month = nil, page = nil)
    # Post.from_year(year).from_month(month).order_by_created_at.page page
    Post.joins('left outer join comments on comments.post_id = posts.id')
        .select('posts.id, posts.created_at, posts.title, posts.content,
                posts.more_content, posts.created_at, count(comments.id) as comments_count')
        .group('posts.id, posts.created_at, posts.title, posts.content, posts.more_content, posts.created_at')
        .from_year(year)
        .from_month(month)
        .order_by_created_at.page page
  end

  private

  def reset_sidebar_token
    AppConfig.refresh_sidebar_mark
  end
end
