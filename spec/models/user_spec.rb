require 'rails_helper'

RSpec.describe User, type: :model do
  it 'responds to attributes' do
    expect(subject).to respond_to(:name)
    expect(subject).to respond_to(:email)
    expect(subject).to respond_to(:password)
    expect(subject).to respond_to(:password_confirmation)
    expect(subject).to respond_to(:posts)
  end

  it 'has many posts' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:post, user: user)

    expect(user.posts.count).to eq 1
  end
end
