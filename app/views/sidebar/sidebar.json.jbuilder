json.sidebar do
  json.new_posts do
    json.array! sidebar.new_posts do |post|
      json.id post[:id]
      json.title post[:title]
      json.created_at post[:created_at]
    end
  end
  json.posts_counts_by_years do
    json.array! sidebar.posts_counts_by_years do |record|
      json.year record.year
      json.count record.count
    end
  end
end
