require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before { @post = FactoryGirl.create(:post) }

  describe 'POST #create' do
    describe 'with valid data' do
      before { post :create, comment: { post_id: @post.id, author: 'author', content: 'content' } }

      it 'returns 200' do
        expect(response).to have_http_status 200
      end

      it 'returns created record in json' do
        expect(response.body).to eq Comment.first.to_json
      end
    end

    describe 'with invalid data' do
      before { post :create, comment: { post_id: @post.id, content: 'content' } }

      it 'returns 422' do
        expect(response).to have_http_status 422
      end

      it 'returns errors' do
        tmp_comment = Comment.new(post_id: @post.id, content: 'content')
        tmp_comment.valid?
        expect(response.body).to eq tmp_comment.errors.to_json
      end
    end
  end

  describe 'DELETE #destroy' do
    # before { post :create, comment: { post_id: @post.id, author: 'author', content: 'content' } }
    let!(:comment) { FactoryGirl.create(:comment, post_id: @post.id) }
    describe 'not logged in' do
      it 'does not delete comment' do
        expect do
          delete :destroy, id: comment.id
        end.to change(Comment, :count).by(0)
      end

      it 'redirects to login' do
        delete :destroy, id: comment.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'logged in' do
      let!(:comment) { FactoryGirl.create(:comment, post_id: @post.id) }

      before do
        log_in(@post.user, no_capybara: true)
      end

      it 'deletes comment' do
        expect do
          delete :destroy, id: comment.id
        end.to change(Comment, :count).by(-1)
      end

      it 'responds with status' do
        delete :destroy, id: comment.id
        expect(response).to have_http_status(204)
      end
    end
  end
end
