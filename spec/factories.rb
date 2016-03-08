FactoryGirl.define do
  factory :user do
    name 'Test_name'
    email 'factory_user@test.pl'
    password 'test1234'
  end

  factory :post do
    title 'Test title'
    content 'Lorem ipsum'
    more_content 'more Lorem ipsum'
    user
  end
end
