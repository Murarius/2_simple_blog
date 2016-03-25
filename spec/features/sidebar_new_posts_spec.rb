require 'rails_helper'

RSpec.feature 'SidebarNewPosts', type: :feature do
  before do
    @user = FactoryGirl.create(:user)
    5.times do
      FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2014))
    end

    5.times do
      FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2013))
    end
  end

  it 'displays 5 monst recent posts links' do
    old_post = FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2010))
    visit root_path
    Post.new_posts.each do |post|
      expect(page).to have_content(post.title)
    end
    expect(page).not_to have_content(old_post.title)
  end
end
