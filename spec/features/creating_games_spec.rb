require 'rails_helper'

RSpec.feature 'Users can create new games' do
  before do
    visit '/'

    click_link 'New Game'

    fill_in 'ID',         with: 2
    fill_in 'Name',       with: 'Ново Лото 7/34'
    fill_in 'Price',      with: 20
    select  'LOTTO',      from: 'Type'
    fill_in 'Commission', with: 0.06
  end

  scenario 'with valid attributes' do

    click_button 'Create Game'

    # page for game creation
    expect(page).to have_content 'Game has been created.'

    # check page title for newly created game in show game
    game = Game.find_by name: 'Ново Лото 7/34'
    expect(page.current_url).to eq game_url(game)

    expect(page).to have_title 'Sales - Games - Ново Лото 7/34'
  end

  scenario "when providing invalid attributes" do
    # use before block...

    click_button 'Create Game'

    # create the same records again
    visit '/'

    click_link 'New Game'

    fill_in 'ID',         with: 2
    fill_in 'Name',       with: 'Ново Лото 7/34'
    fill_in 'Price',      with: 20
    select  'LOTTO',      from: 'Type'
    fill_in 'Commission', with: 0.06
    click_button 'Create Game'

    expect(page).to have_content 'Game has not been created.'
    # expect(page).to have_content "Name can't be blank."
  end
end
