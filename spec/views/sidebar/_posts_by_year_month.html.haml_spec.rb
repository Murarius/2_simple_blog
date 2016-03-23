require 'rails_helper'

RSpec.describe 'sidebar/_posts_by_year_month.html.haml', type: :view do
  before do
    @user = FactoryGirl.create(:user)
    5.times { FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2016)) }
    @sidebar = Sidebar.new
  end

  it 'displays year with count of posts from year' do
    assign(:sidebar, @sidebar)
    render
    expect(rendered).to have_content('2016 (5)')
  end
end
