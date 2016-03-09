require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views

  before do
    @post = FactoryGirl.create(:post)
  end

  describe 'GET #show' do
    it 'with success' do
      get :show, id: @post.id
      expect(response).to have_http_status(:success)
      expect(response.body).to have_content(@post.title)
    end

    it 'rerurns more content field' do
      get :show, id: @post.id
      expect(response.body).to have_content(@post.more_content)
    end
  end

  describe 'GET #new' do
    it 'with success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create'

  describe 'GET #edit' do
    it 'with success' do
      get :edit, id: @post.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update'
  describe 'DELETE #destroy'
end
