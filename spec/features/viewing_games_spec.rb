require 'rails_helper'

RSpec.feature 'Users can view games' do
  scenario 'with the games details' do
    game = FactoryGirl.create :game, name: 'Ново Лото 7/34'
    
    visit '/'

    click_link 'Ново Лото 7/34'
    expect(page.current_url).to eq game_url(game)
  end
end
