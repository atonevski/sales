require 'rails_helper'

RSpec.feature 'Users can edit existing games' do
  before do
    FactoryGirl.create :game, name: 'Ново Лото 7/34'

    visit '/'
    click_link 'Ново Лото 7/34'
    click_link 'Edit Game'
  end

  scenario 'with valid attributes' do

    fill_in 'Name', with: 'Лото 7/34'
    click_button 'Update Game'

    expect(page).to have_content 'Game has been updated.'
    expect(page).to have_content 'Лото 7/34'
  end

  scenario 'when providing invalid attributes' do
    # duplicate name
    fill_in 'Name', with: ''
    click_button 'Update Game'

    expect(page).to have_content 'Game has not been updated.'
  end
end