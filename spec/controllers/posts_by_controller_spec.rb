require 'rails_helper'

RSpec.describe PostsByController, type: :controller do
  describe 'GET #year_posts_months_counts' do
    render_views
    before do
      @user = FactoryGirl.create(:user)
      10.times do |i|
        FactoryGirl.create(:post, user: @user, created_at: Date.new(2012, i + 1))
      end
    end

    it 'returns success' do
      get :year_posts_months_counts, year: 2012
      expect(response).to have_http_status(200)
    end

    it 'returns posts counts in months' do
      get :year_posts_months_counts, year: 2012
      expect(response.body).to have_content('January (1)')
    end

    it 'creates proper month links' do
      get :year_posts_months_counts, year: 2012
      expect(response.body).not_to have_xpath("//a[@href='#{root_path(@post)}?month=Janunary&year=2012']")
    end
  end
end
