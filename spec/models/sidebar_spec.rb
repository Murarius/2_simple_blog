require 'rails_helper'

RSpec.describe Sidebar, type: :model do
  it 'responds to attributes' do
    expect(subject).to respond_to(:new_posts)
    expect(subject).to respond_to(:popular_posts)
    expect(subject).to respond_to(:posts_counts_by_years)
  end

  describe 'loads' do
    before do
      @user = FactoryGirl.create(:user)
      5.times { FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2012)) }
      5.times { FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2016)) }
    end

    let(:sidebar) { Sidebar.new }

    it 'valid new posts' do
      expect(sidebar.new_posts).to eq Post.new_posts
    end

    it 'valid posts counts by years' do
      expect(sidebar.posts_counts_by_years).to eq Post.counts_by_years
    end
  end
end
