require 'rails_helper'

RSpec.feature 'Useres can delete categories' do
  let(:game) { FactoryGirl.create :game }
  let(:category) { FactoryGirl.create :category, game_id: game.id }

  before do
    user = FactoryGirl.create :user
    assign_role! user, :manager, game.class.name.singularize.camelize
    login_as user

    visit game_category_path game, category
  end

  scenario 'successfully' do
    click_link 'Delete Category'

    expect(page).to have_content 'Category has been deleted.'
    expect(page.current_url).to eq game_url(game)
  end
end
