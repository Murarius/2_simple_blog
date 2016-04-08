require 'rails_helper'

RSpec.feature 'ReactCommentsComponent', type: :feature do
  describe 'at post show page' do
    before do
      post = FactoryGirl.create(:post)
      4.times { FactoryGirl.create(:comment, post_id: post.id) }
    end

    it 'displays all comments of Post', js: true do
      post = Post.first
      visit post_path(post.id)
      post.comments.each do |comment|
        expect(page).to have_content(comment.content)
        expect(page).to have_content(comment.author.upcase)
      end
    end

    it 'displays comments count of Post', js: true do
      post = Post.first
      visit post_path(post.id)
      expect(page).to have_content("Comments: #{post.comments.count}")
    end

    it 'displays new comment form', js: true do
      post = Post.first
      visit post_path(post.id)
      expect(page).to have_content('ADD COMMENT')
    end
  end

  describe 'add comment', js: true do
    let(:post) { FactoryGirl.create(:post) }

    describe 'with valid input' do
      it 'displays new comment' do
        visit post_path(post.id)
        fill_in('input-author', with: 'new author')
        fill_in('input-content', with: 'new content')
        click_link('Add Comment')
        sleep(2)
        expect(page).to have_content(Comment.first.content)
      end

      it 'increments comments count' do
        visit post_path(post.id)
        expect(page).to have_content('Comments: 0')
        expect(Comment.all.count).to eq 0
        fill_in('input-author', with: 'new author')
        fill_in('input-content', with: 'new content')
        click_link('Add Comment')
        sleep(2)
        expect(Comment.all.count).to eq 1
        expect(page).to have_content("Comments: #{Post.first.comments.count}")
      end
    end

    describe 'with invalid input' do
      it 'not incrase comments count' do
        visit post_path(post.id)
        expect(page).to have_content('Comments: 0')
        fill_in('input-content', with: 'new content')
        click_link('Add Comment')
        sleep(2)
        expect(page).to have_content('Comments: 0')
      end

      it 'dont add record' do
        visit post_path(post.id)
        expect do
          fill_in('input-content', with: 'new content')
          click_link('Add Comment')
          sleep(2)
        end.to change(Comment.all, :count).by 0
      end

      it 'displays errors' do
        tmp_comment = post.comments.new(content: 'new content')
        tmp_comment.valid?
        visit post_path(post.id)
        fill_in('input-content', with: 'new content')
        click_link('Add Comment')
        sleep(2)
        tmp_comment.errors.each do |key, value|
          expect(page).to have_content(key)
          expect(page).to have_content(value)
        end
      end
    end
  end
end
