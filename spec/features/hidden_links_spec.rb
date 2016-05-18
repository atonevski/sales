require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let(:user)  { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:agent) { FactoryGirl.create :agent }
  let(:game)  { FactoryGirl.create :game }

  context 'anonymous users' do
    scenario 'cannot see the New Game link' do
      visit '/'
      expect(page).not_to have_link 'New Game'
    end

    scenario 'cannot see Delete Game link' do
      visit game_path(game)
      expect(page).not_to have_link 'Delete Game'
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
      login_as(user)
    end

    scenario 'cannot see the New Game link' do
      visit '/'
      expect(page).not_to have_link 'New Game'
    end

    scenario 'cannot see the Delete Game link' do
      visit game_path(game)
      expect(page).not_to have_link 'Delete Game'
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
  end
end
