require 'rails_helper'

RSpec.feature 'LoginsLogouts', type: :feature do
  before do
    @password = 'test1234'
    @user = FactoryGirl.create(:user, password: @password)
  end

  describe 'login' do
    it 'succeses with valid data' do
      visit root_path
      expect(page).not_to have_link('', href: '/logout')
      log_in(@user)
      expect(page).to have_content('Signed in successfully.')

      expect(page).to have_link('', href: '/logout')
      expect(page).to have_link('', href: new_post_path)
    end

    it 'fails with invalid data' do
      visit root_path
      find_link('', href: '/login').click
      fill_in 'Email', with: 'missing user email'
      fill_in 'Password', with: 'missing password'
      find('input[type=submit]').click
      expect(page).to have_content('Invalid email or password.')
    end
  end

  describe 'logout' do
    it 'successes' do
      visit root_path
      log_in(@user)
      expect(page).to have_link('', href: '/logout')
      find_link('', href: '/logout').click
      expect(page).to have_content('Signed out successfully.')
    end
  end
end
