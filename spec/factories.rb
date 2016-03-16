FactoryGirl.define do
  factory :user do
    name 'Test_name'
    email 'factory_user@test.pl'
    password 'test1234'
  end

  factory :post do
    sequence(:title) { |n| "Post title #{n}" }
    sequence(:content) { |n| "Post content #{n}" }
    sequence(:more_content) { |n| "More post content #{n}" }
    user
  end
end
