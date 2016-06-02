require 'rails_helper'

RSpec.feature 'Admins can create roles' do
  let(:admin) { FactoryGirl.create :user, :admin }
  let!(:user) { FactoryGirl.create :user, id: 2, email: 'editor@example.com' }

  before do
    login_as admin

    visit root_path
    click_link 'Admin'
    click_link 'Roles'
    click_link 'New Role'
  end

  scenario 'with valid attributes' do
    select user.email, from: 'User'
    select 'manager', from: 'Role'
    select 'Agent', from: 'Model'
    click_button 'Create Role'

    expect(page).to have_content 'Role has been created.'
    expect(page).to have_content user.email
    within 'table tr', text: user.email do
      expect(page).to have_content('Agent')
      expect(page).not_to have_content 'Game'
    end
  end

  scenario 'with invalid attributes' do
    FactoryGirl.create :role, user_id: user.id, role: :viewer, model: 'Game'

    select user.email, from: 'User'
    select 'viewer', from: 'Role'
    select 'Game', from: 'Model'
    click_button 'Create Role'

    expect(page).to have_content 'Role has not been created.'
    expect(page).to have_content "role for user_id and model already exists"

  end
end
