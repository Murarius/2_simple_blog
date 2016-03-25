require 'rails_helper'

RSpec.feature 'SidebarPostsByYears', type: :feature do
  before do
    @user = FactoryGirl.create(:user)
    5.times do
      FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2012, 1))
      FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2013, 1))
    end
  end

  it 'displays post counts in years' do
    visit root_path
    expect(page).to have_content('2012 (5)')
    expect(page).to have_content('2013 (5)')
  end

  describe 'year caret links', js: true do
    before { visit root_path }
    it 'displays post counts in monts after first click and hides after second click' do
      find_link('2012', href: '#').click
      expect(page).to have_content('January (5)')
      find_link('2012', href: '#').click
      expect(page).not_to have_content('January (5)')
    end
  end

  it 'year link redirects to posts created at year from link' do
    visit root_path
    expect(page).to have_css('.post-date', count: 10)
    find_link('2012', href: '/?year=2012').click
    expect(page).to have_css('.post-date', count: 5)
  end

  it 'month link redirects to posts created at month from link', js: true do
    FactoryGirl.create(:post, user_id: @user.id, created_at: Date.new(2013, 2))
    visit root_path
    expect(page).to have_css('.post-date', count: 10)
    find_link('2013', href: '#').click
    find_link('February', href: '/?month=February&year=2013').click
    expect(page).to have_css('.post-date', count: 1)
  end
end
