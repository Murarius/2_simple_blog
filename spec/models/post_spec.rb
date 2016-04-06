require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'responds to attributes' do
    expect(subject).to respond_to(:title)
    expect(subject).to respond_to(:content)
    expect(subject).to respond_to(:more_content)
    expect(subject).to respond_to(:created_at)
    expect(subject).to respond_to(:user)
    expect(subject).to respond_to(:comments)
  end

  describe 'to be valid' do
    let(:post) { FactoryGirl.build(:post) }

    it 'must have title' do
      expect { post.title = nil }.to change { post.valid? }.from(true).to(false)
    end

    it 'must have content' do
      expect { post.content = nil }.to change { post.valid? }.from(true).to(false)
    end

    it 'must have user' do
      expect { post.user = nil }.to change { post.valid? }.from(true).to(false)
    end
  end

  it 'belongs to User' do
    user = FactoryGirl.build(:user)
    post = FactoryGirl.build(:post, user: user)
    expect(post.user).to eq user
  end

  describe 'scope' do
    before do
      @user = FactoryGirl.create(:user)
      @old_post = FactoryGirl.create(:post, user: @user, created_at: Date.new(2012))
      @new_post = FactoryGirl.create(:post, user: @user)
    end

    it 'order_by_created_at brings valid data' do
      expect(Post.all.first).to eq @old_post
      expect(Post.order_by_created_at.first).to eq @new_post
    end

    it 'from_year brings valid data' do
      expect(Post.from_year(2012).count).to eq 1
    end

    it 'counts_by_year brings valid data' do
      FactoryGirl.create(:post, user: @user, created_at: Date.new(2012))
      expect(Post.counts_by_years[1][:year]).to eq '2012' # 1 index - last element
      expect(Post.counts_by_years[1][:count]).to eq 2
    end

    it 'counts_by_month brings valid data' do
      3.times { FactoryGirl.create(:post, user: @user, created_at: Date.new(2013, 1, 1)) }
      expect(Post.counts_by_months(2013).first.month).to eq 'January'
      expect(Post.counts_by_months(2013).first.count).to eq 3
    end
  end
end
