require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let(:user)  { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:agent) { FactoryGirl.create :agent }
  let(:game)  { FactoryGirl.create :game }
  let(:category)  { FactoryGirl.create :category, game_id: game.id }

  before do
    # assign_role! user, :viewer, game.class.name.singularize.camelize

    # login_as user
  end

  context 'anonymous users' do
    scenario 'cannot see the New Game link' do
      visit '/'
      expect(page).not_to have_link 'New Game'
    end

    scenario 'cannot see Delete Game link' do
      visit game_path(game)
      expect(page).not_to have_link 'Delete Game'
    end
    
    scenario 'cannot see New Category link' do
      visit game_path(game)
      expect(page).not_to have_link 'New Category'
    end

    scenario 'cannot see Edit Category link' do
      visit game_category_path(game, category)
      expect(page).not_to have_link 'Edit Category'
    end

    scenario 'cannot see Delete Category link' do
      visit game_category_path(game, category)
      expect(page).not_to have_link 'Delete Category'
    end

    scenario 'cannot see the New Agent link' do
      visit '/agents'
      expect(page).not_to have_link 'New Agent'
    end

    scenario 'cannot see the Delete Agent link' do
      visit agent_path(agent)
      expect(page).not_to have_link 'Delete Agent'
    end

  end

  context 'regular users' do
    before do
      assign_role! user, :viewer, game.class.name.singularize.camelize
      login_as(user)
    end

    scenario 'cannot see the New Game link' do
      visit '/'
      expect(page).not_to have_link 'New Game'
    end

    scenario 'cannot see the New Category link' do
      visit game_path(game)
      expect(page).not_to have_link 'New Category'
    end

    scenario 'cannot see the Delete Game link' do
      visit game_path(game)
      expect(page).not_to have_link 'Delete Game'
    end

    scenario 'cannot see Edit Category link' do
      visit game_category_path(game, category)
      expect(page).not_to have_link 'Edit Category'
    end

    scenario 'cannot see Delete Category link' do
      visit game_category_path(game, category)
      expect(page).not_to have_link 'Delete Category'
    end
    scenario 'cannot see the New Agent link' do
      visit '/agents'
      expect(page).not_to have_link 'New Agent'
    end

    scenario 'cannot see the Delete Agent link' do
      visit agent_path(agent)
      expect(page).not_to have_link 'Delete Agent'
    end
  end

  context 'users as editors for games' do
    before do
      assign_role! user, :editor, 'Game'
      login_as user
    end

    scenario 'can see Edit Game' do

      visit game_path(game)
      expect(page).to have_link 'Edit Game'
    end

    scenario 'can see Edit Category' do
      category = FactoryGirl.create :category, game_id: game.id

      visit game_category_path(game, category)
      expect(page).to have_link 'Edit Category'
    end

    scenario "can't see Delete Category" do
      category = FactoryGirl.create :category, game_id: game.id

      visit game_category_path(game, category)
      expect(page).not_to have_link 'Delete Category'
    end
  end

  context 'users as managers for games' do
    before do
      assign_role! user, :manager, 'Game'
      login_as user
    end

    scenario 'can see New Game' do

      visit root_path
      expect(page).to have_link 'New Game'
    end

    scenario 'can see Edit Category' do
      category = FactoryGirl.create :category, game_id: game.id

      visit game_category_path(game, category)
      expect(page).to have_link 'Edit Category'
    end

    scenario "can see Delete Category" do
      category = FactoryGirl.create :category, game_id: game.id

      visit game_category_path(game, category)
      expect(page).to have_link 'Delete Category'
    end
  end

  context 'admin' do
    before do
      login_as admin
    end

    scenario 'can see New Game link' do
      visit '/'
      expect(page).to have_link 'New Game'
    end

    scenario 'can see Delete Game link' do
      visit game_path(game)
      expect(page).to have_link 'Delete Game'
    end

    scenario 'can see New Agent link' do
      visit '/agents'
      expect(page).to have_link 'New Agent'
    end

    scenario 'can see Delete Agent link' do
      visit agent_path(agent)
      expect(page).to have_link 'Delete Agent'
    end

    scenario 'can see Edit Category' do
      category = FactoryGirl.create :category, game_id: game.id

      visit game_category_path(game, category)
      expect(page).to have_link 'Edit Category'
    end

    scenario "can see Delete Category" do
      category = FactoryGirl.create :category, game_id: game.id

      visit game_category_path(game, category)
      expect(page).to have_link 'Delete Category'
    end
  end
end
