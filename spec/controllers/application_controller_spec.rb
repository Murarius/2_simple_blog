require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    5.times { FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2014)) }
    5.times { FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2013)) }
    # log_in(@user, no_capybara: true)
  end

  # controller(PostsController) {}

  describe 'cookie is empty' do
    it 'generates new sidebar' do
      expect(subject).to receive(:create_new_sidebar)
      subject.load_sidebar
    end

    it 'saves cookie in browser' do
      expect(cookies[:sidebar]).to eq nil
      subject.load_sidebar
      expect(cookies[:sidebar]).to eq Sidebar.new.to_json
    end
  end

  describe 'cookie is not empty' do
    before { cookies[:sidebar] = Sidebar.new.to_json }

    describe 'sidebar mark is valid' do
      before { cookies[:sidebar_mark] = AppConfig.sidebar_mark }
      it 'creates sidebar from cookie' do
        expect(Sidebar).to receive(:new_from_cookie).with(cookies[:sidebar])
        subject.load_sidebar
      end

      describe 'creates new sidebar after' do
        controller do
          def create
            Post.new(title: params[:post][:title],
                     content: params[:post][:content],
                     user_id: params[:post][:user_id]).save
            redirect_to root_path
          end

          def update
            Post.find(params[:id]).update(title: params[:post][:title])
            redirect_to root_path
          end

          def destroy
            Post.find(params[:id]).destroy
            redirect_to root_path
          end
        end

        it 'creating new post record' do
          expect(subject).to receive(:create_new_sidebar)
          post :create, post: { title: 'Title Text', content: 'Content Text', user_id: @user.id }
          subject.load_sidebar
        end

        it 'updating post record' do
          expect(subject).to receive(:create_new_sidebar)
          patch :update, id: Post.first.id, post: { title: 'New Title Text' }
          subject.load_sidebar
        end

        it 'deleting new post record' do
          expect(subject).to receive(:create_new_sidebar)
          delete :destroy, id: Post.first.id
          subject.load_sidebar
        end
      end
    end

    describe 'sidebar mark is not valid' do
      before { cookies[:sidebar_mark] = 'invalid token' }
      it 'creates new sidebar' do
        expect(subject).to receive(:create_new_sidebar)
        subject.load_sidebar
        expect(cookies[:sidebar]).to eq Sidebar.new.to_json
      end
    end
  end
end
