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
  scope :new_posts, -> { select('id, title, created_at').order('created_at DESC').limit(5) }
  scope :from_year, ->(year = nil) { where("to_char(created_at, 'YYYY') = ?", year.to_s) if year }
  scope :from_month, ->(month = nil) { where("to_char(created_at, 'MM') = ?", @months[month]) if month }

  scope :counts_by_years, -> do
    select("to_char(created_at, 'YYYY') as year, count(*) as count")
      .group('year')
      .order('year DESC')
  end

  scope :counts_by_months, ->(year) do
    select("regexp_replace(to_char(created_at, 'Month'), '\s+$', '') as month,
            to_char(created_at, 'MM') as month_number, count(*) as count")
      .where("to_char(created_at, 'YYYY') = ?", year.to_s)
      .group('month, month_number')
      .order('month_number')
  end

  def self.load_to_home(year, month, page)
    Post.from_year(year).from_month(month).order_by_created_at.page page
  end

  private

  def reset_sidebar_token
    AppConfig.refresh_sidebar_mark
  end
end
