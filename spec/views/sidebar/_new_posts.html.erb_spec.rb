require 'rails_helper'

RSpec.describe 'sidebar/_new_posts.html.erb', type: :view do
  before do
    @user = FactoryGirl.create(:user)
    @new_posts = []
    5.times { @new_posts.push(FactoryGirl.create(:post, user_id: @user.id)) }
  end

  it 'displays 5 newest posts' do
    assign(:new_posts, @new_posts)
    render
    expect(rendered).to have_content(@new_posts.first.title)
    expect(rendered).to have_content(time_ago_in_words(@new_posts.first.created_at))
  end
end
