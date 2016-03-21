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

  def self.post_counts_by_year
    counts_by_year.map { |record| { year: record.year, count: record.count } }
  end

  def self.post_counts_by_month(year)
    counts_by_month(year).map { |record| { month: record.month.strip, count: record.count } }
  end

  private

  scope :counts_by_year, -> do
    select("to_char(created_at, 'YYYY') as year, count(*) as count")
      .group('year')
      .order('year DESC')
  end

  scope :counts_by_month, ->(year) do
    select("to_char(created_at, 'Month') as month, to_char(created_at, 'MM') as month_number, count(*) as count")
      .where("to_char(created_at, 'YYYY') = ?", year.to_s)
      .group('month, month_number')
      .order('month_number')
  end
end
