require 'rails_helper'

RSpec.feature 'Users can create new categories' do
  before do
    user = FactoryGirl.create :user
    game = FactoryGirl.create(:game, name: 'Instant Game')
    assign_role! user, :viewer, game.class.name.singularize.camelize
    login_as user

    visit game_path(game)
    click_link 'New Category'
  end

  scenario 'with valid attributes' do
    fill_in 'Category', with: 1
    fill_in 'Count', with: 1
    fill_in 'Amount', with: 100_000
    fill_in 'Description', with: 'First category prize'
    click_button 'Create Category'

    expect(page).to have_content 'Category has been created.'
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Category'

    expect(page).to have_content 'Category has not been created.'
    expect(page).to have_content "Category can't be blank"
    expect(page).to have_content "Count can't be blank"
    expect(page).to have_content "Amount can't be blank"
  end
end
#Rails generate model Category category:integer count:integer amount:decimal desc:text game:references
