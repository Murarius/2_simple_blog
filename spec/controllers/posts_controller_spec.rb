require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views

  before do
    @post = FactoryGirl.create(:post)
  end

  describe 'GET #show' do
    it 'returns success' do
      get :show, id: @post.id
      expect(response).to have_http_status(200)
      expect(response.body).to have_content(@post.title)
    end

    it 'returns more_content field' do
      get :show, id: @post.id
      expect(response.body).to have_content(@post.more_content)
    end
  end

  describe 'GET #new' do
    it 'when logged in returns success' do
      log_in(@post.user, no_capybara: true)
      get :new
      expect(response).to have_http_status(200)
    end

    it 'when not logged in redirects' do
      get :new
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #create' do
    describe 'after log in' do
      before do
        log_in(@post.user, no_capybara: true)
        @request.env['devise.mapping'] = Devise.mappings[:user]
      end

      describe 'with valid data' do
        it 'adds new record' do
          expect do
            post :create, post: { title: 'Lorem', content: 'Lorem', more_content: 'Lorem' }
          end.to change { Post.all.count }.by(1)
        end

        it 'redirects to root_path' do
          post :create, post: { title: 'Lorem', content: 'Lorem', more_content: 'Lorem' }
          expect(response).to redirect_to(root_path)
          expect(response).to have_http_status(302)
        end
      end

      describe 'with invalid data' do
        before do
          @post_hash = { title: 'Lorem' }
          @post_obj = Post.new(@post_hash)
        end

        it 'rerenders new template with error messages' do
          @post_obj.validate
          post :create, post: @post_hash
          expect(response).to have_http_status(200)
          expect(response).to render_template('new')
          # first error in response body
          expect(response.body).to have_content(@post_obj.errors.messages.to_a[0].join(' '))
        end

        it 'dont add new record' do
          expect do
            post :create, post: @post_hash
          end.to change { Post.all.count }.by(0)
        end
      end
    end

    describe 'when not logged in' do
      it 'redirects' do
        post :create, post: { title: 'Lorem', content: 'Lorem', more_content: 'Lorem' }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET #edit' do
    it 'when logged in returns success' do
      log_in(@post.user, no_capybara: true)
      get :edit, id: @post.id
      expect(response).to have_http_status(200)
    end

    it 'when not logged in redirects' do
      get :edit, id: @post.id
      expect(response).to have_http_status(302)
    end
  end

  describe 'PATCH #update' do
    describe 'after log in' do
      before do
        log_in(@post.user, no_capybara: true)
        @request.env['devise.mapping'] = Devise.mappings[:user]
      end

      describe 'with valid data' do
        it 'redirects to root' do
          patch :update, id: @post.id, post: { title: 'New Lorem' }
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_path)
        end

        it 'updates record' do
          patch :update, id: @post.id, post: { title: 'New Lorem' }
          expect(@post.reload.title).to eq 'New Lorem'
        end
      end

      describe 'with invalid data' do
        it 'rerenders edit template with error messages' do
          patch :update, id: @post.id, post: { title: '' }
          expect(response).to have_http_status(200)
          expect(response).to render_template('edit')
          expect(response.body).to have_content("can't be blank")
        end
      end
    end

    describe 'when not logged in' do
      it 'redirects' do
        patch :update, id: @post.id, post: { title: 'New Lorem' }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'when not looged in' do
      it 'redirects to root with message' do
        post :destroy, id: @post.id
        expect(response).to have_http_status(302)
        expect(flash.first[0]).to eq 'alert'
        expect(flash.first[1]).to eq 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'when looged in' do
      before do
        log_in(@post.user, no_capybara: true)
      end

      it 'deletes record' do
        expect do
          post :destroy, id: @post.id
        end.to change { Post.all.count }.by(-1)
      end

      it 'redirects to with message' do
        post :destroy, id: @post.id
        expect(response).to have_http_status(302)
        expect(flash.first[0]).to eq 'notice'
        expect(flash.first[1]).to eq 'Post deleted.'
      end
    end
  end
end
