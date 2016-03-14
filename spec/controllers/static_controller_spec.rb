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

    it 'has no post edit/delete buttons when not logged in' do
      get :home
      expect(response.body).to have_link('', href: '/login')
      expect(response.body).not_to have_link('', href: '/logout')
      # expect(response.body).not_to have_link('', href: edit_post_path(@post))
      # expect(response.body).not_to have_link('', href: post_path(@post))
      expect(response.body).not_to have_xpath("//a[@href='#{edit_post_path(@post)}' and @class='button edit']")
      expect(response.body).not_to have_xpath("//a[@href='#{post_path(@post)}' and @class='button delete']")

    end

    it 'has post edit/delete buttons when logged in' do
      log_in(@post.user, no_capybara: true)
      get :home
      expect(response.body).not_to have_link('', href: '/login')
      expect(response.body).to have_link('', href: '/logout')
      expect(response.body).to have_xpath("//a[@href='#{edit_post_path(@post)}' and @class='button edit']")
      expect(response.body).to have_xpath("//a[@href='#{post_path(@post)}' and @class='button delete']")
    end

  end
end
