require 'rails_helper'

RSpec.feature 'LoginsLogouts', type: :feature do
  # flash
  before do
    @password = 'test1234'
    @user = User.create!(name: 'test', email: 'test@test.pl', password: @password, password_confirmation: @password)
  end

  describe 'login' do
    it 'succeses with valid data' do
      visit root_path
      expect(page).not_to have_content('Log out')
      find('.log-in-out-menu a').click
      fill_in 'Email', with: 'test@test.pl'
      fill_in 'Password', with: 'test1234'
      find('.actions').find('.button').click
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Log out')
    end

    it 'fails with invalid data' do
      visit root_path
      find('.log-in-out-menu a').click
      fill_in 'Email', with: 'missing user name'
      fill_in 'Password', with: 'missing password'
      find('.actions').find('.button').click
      expect(page).to have_content('Invalid email or password.')
    end
  end

  describe 'logout' do
    it 'successes' do
      visit root_path
      log_in(@user.email, @password)
      expect(page).to have_content('Log out')
      find('.log-in-out-menu a').click
      expect(page).to have_content('Signed out successfully.')
    end
  end
end
