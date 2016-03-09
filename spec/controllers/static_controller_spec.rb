require 'rails_helper'

RSpec.describe StaticController, type: :controller do
  render_views

  before do
    @post = FactoryGirl.create(:post)
  end

  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
    end

    it 'returns post title' do
      get :home
      expect(response.body).to have_content(@post.title)
    end
  end
end
