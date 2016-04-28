require 'rails_helper'

RSpec.feature 'Users can create new games' do
  scenario 'with valid attributes' do
    visit '/'

    click_link 'New Game'

    fill_in 'ID',         with: 2
    fill_in 'Name',       with: 'Ново Лото 7/34'
    fill_in 'Price',      with: 20
    select  'LOTTO',      from: 'Type'
    fill_in 'Commission', with: 0.06

    click_button 'Create Game'

    expect(page).to have_content 'Game has been created.'
  end
# Rails generate model game name:string type:string desc:text parent:integer price:decimal volume:integer commission:decimal
end
