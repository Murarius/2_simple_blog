require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'responds to attributes' do
    expect(subject).to respond_to(:content)
    expect(subject).to respond_to(:author)
    expect(subject).to respond_to(:post)
    expect(subject).to respond_to(:created_at)
  end

  describe 'to be valid' do
    let(:comment) { FactoryGirl.build(:comment) }

    it 'must have author' do
      expect { comment.author = nil }.to change { comment.valid? }.from(true).to(false)
    end

    it 'must have content' do
      expect { comment.content = nil }.to change { comment.valid? }.from(true).to(false)
    end

    it 'must have post' do
      expect { comment.post = nil }.to change { comment.valid? }.from(true).to(false)
    end
  end

  it 'belongs to Post' do
    post = FactoryGirl.build(:post)
    comment = FactoryGirl.build(:comment, post: post)
    expect(comment.post).to eq post
  end

  it 'returns time ago in words date when json' do
    comment = FactoryGirl.create(:comment)
    # somthing like 2 minutes ago <- check if ago exists
    expect(comment.to_json.include?('ago')).to be true
  end
end
