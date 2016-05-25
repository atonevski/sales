require 'rails_helper'

RSpec.feature 'Users can view categories' do
  before do
    inst_game = FactoryGirl.create :game,  name: 'Instant game', type: 'INSTANT'
    FactoryGirl.create :category, game_id: inst_game.id, desc: 'Instant game -- Category 1'

    inst2_game = FactoryGirl.create :game, id: 2, name: 'Other scratch game', type: 'INSTANT'
    FactoryGirl.create :category, game_id: inst2_game.id, desc: 'Other scratch game -- Category 1'

    user = FactoryGirl.create :user
    assign_role! user, :viewer, inst_game.class.name.singularize.camelize

    login_as user
    visit '/'
  end

  scenario 'for given game' do
    click_link 'Instant game'
    
    expect(page).to have_content 'Instant game -- Category 1'
    expect(page).to_not have_content 'Other scratch game -- Category 1'

    # don't know how to jump to game/:game_id/category/:id 
  end

end
