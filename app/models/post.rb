# class Post < ActiveRecord::Base
class Post < ActiveRecord::Base
  belongs_to :user

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
  scope :new_posts, -> { order('created_at').limit(5) }

  scope :from_year, ->(year = nil) do
    where("to_char(created_at, 'YYYY') = ?", year.to_s) if year
  end

  scope :from_month, ->(month = nil) do
    where("to_char(created_at, 'MM') = ?", @months[month]) if month
  end

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
    Post.order_by_created_at.from_year(year).from_month(month).page page
  end
end
