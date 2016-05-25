require 'rails_helper'

RSpec.feature 'Users can view games' do
  let(:user) { FactoryGirl.create :user }
  let(:game) { FactoryGirl.create :game, name: 'Ново Лото 7/34' }

  before do 
    login_as user
    assign_role! user, :viewer, game.class.name.singularize.camelize
  end

  scenario 'with the games details' do
    visit '/'

    click_link 'Ново Лото 7/34'
    expect(page.current_url).to eq game_url(game)
  end
end
