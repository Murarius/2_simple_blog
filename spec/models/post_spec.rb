require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'responds to attributes' do
    expect(subject).to respond_to(:title)
    expect(subject).to respond_to(:content)
    expect(subject).to respond_to(:more_content)
    expect(subject).to respond_to(:created_at)
    expect(subject).to respond_to(:user)
  end

  it 'belongs to User' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user: user)

    expect(post.user).to eq user
  end
end
