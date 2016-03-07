require 'rails_helper'

RSpec.describe 'Session', type: :routing do
  it 'responds to login' do
    expect(get: '/login').to route_to('devise/sessions#new')
  end

  it 'responds to logout' do
    expect(delete: '/logout').to route_to('devise/sessions#destroy')
  end
end
