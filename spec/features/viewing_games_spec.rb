require 'rails_helper'

RSpec.feature 'Users can view games' do
  let(:user) { FactoryGirl.create :user }
  let!(:game) { FactoryGirl.create :game, name: 'Ново Лото 7/34' }

#   before do 
#     login_as user
#     assign_role! user, :viewer, game.class.name.singularize.camelize
#   end

  scenario 'with the games details' do
    assign_role! user, :viewer, game.class.name.singularize.camelize
    login_as user

    visit '/'

    click_link 'Ново Лото 7/34'
    expect(page.current_url).to eq game_url(game)
  end

  scenario 'unless they do not have permission' do
    
    visit root_path
    expect(page).not_to have_content 'Ново Лото 7/34'
  end
end
