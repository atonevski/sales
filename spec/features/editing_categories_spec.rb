require 'rails_helper'

RSpec.feature 'Users can edit existing categories' do
  let(:game) { FactoryGirl.create :game }
  let(:category) { FactoryGirl.create :category, game_id: game.id }

  before do
    visit game_category_path game, category
    click_link 'Edit Category'
  end

  scenario 'with valid attributes' do
    fill_in 'Amount', with: 1_000_001
    click_button 'Update Category'

    expect(page).to have_content 'Category has been updated.'

    # check within clause... 
    within '#amount' do
      expect(page).to have_content 1_000_001
      expect(page).not_to have_content category.amount
    end
  end

  scenario 'with invalid attributes' do
    fill_in 'Category', with: ''
    click_button 'Update Category'

    expect(page).to have_content 'Category has not been updated.'
  end
end
