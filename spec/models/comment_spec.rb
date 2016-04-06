require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'responds to attributes' do
    expect(subject).to respond_to(:content)
    expect(subject).to respond_to(:author)
    expect(subject).to respond_to(:post)
    expect(subject).to respond_to(:created_at)
  end
end
