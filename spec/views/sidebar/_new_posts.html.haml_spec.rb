require 'rails_helper'

RSpec.describe 'sidebar/_new_posts.html.haml', type: :view do
  before do
    @user = FactoryGirl.create(:user)
    5.times { FactoryGirl.create(:post, user_id: @user.id) }
    @sidebar = Sidebar.new
  end

  it 'displays 5 newest posts' do
    assign(:sidebar, @sidebar)
    render
    expect(rendered).to have_content(Post.all.first.title)
    expect(rendered).to have_content(time_ago_in_words(Post.all.first.created_at))
  end
end
