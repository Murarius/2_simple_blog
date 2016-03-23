require 'rails_helper'

RSpec.describe 'Session', type: :routing do
  it 'responds to login' do
    expect(get: '/login').to route_to('users/sessions#new')
  end

  it 'responds to logout' do
    expect(delete: '/logout').to route_to('users/sessions#destroy')
  end
end
