require 'rails_helper'

RSpec.feature 'LoginsLogouts', type: :feature do
  before do
    @password = 'test1234'
    @user = FactoryGirl.create(:user, password: @password)
  end

  describe 'login' do
    it 'succeses with valid data' do
      visit root_path
      expect(page).not_to have_content('Log out')
      log_in(@user.email, @password)
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Log out')
      expect(page).to have_content('Add Post')
    end

    it 'fails with invalid data' do
      visit root_path
      log_in('missing user email', 'missing password')
      expect(page).to have_content('Invalid email or password.')
    end
  end

  describe 'logout' do
    it 'successes' do
      visit root_path
      log_in(@user.email, @password)
      expect(page).to have_content('Log out')
      first('.log-in-out-menu a').click
      expect(page).to have_content('Signed out successfully.')
    end
  end
end
