require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'responds to attributes' do
    expect(subject).to respond_to(:title)
    expect(subject).to respond_to(:content)
    expect(subject).to respond_to(:more_content)
    expect(subject).to respond_to(:created_at)
    expect(subject).to respond_to(:user)
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
end
