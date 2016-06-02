require 'rails_helper'

RSpec.feature 'Admins can edit roles' do
  let(:admin) { FactoryGirl.create :user, :admin }
  let!(:user) { FactoryGirl.create :user, id: 2, email: 'editor@example.com' }

  before do
    FactoryGirl.create :role, user_id: user.id, role: :viewer, model: 'Game'
    FactoryGirl.create :user, id: 3, email: 'manager@example.com'

    login_as admin

    visit root_path
    click_link 'Admin'
    click_link 'Roles'
    click_link 'editor@example.com'
    click_link 'Edit Role'

  end

  scenario 'only role can be changed' do
    # select 'manager@example.com', from: 'User'
    select 'manager', from: 'Role'
    # select 'Agent', from: 'Model'
    click_button 'Update Role'

    expect(page).to have_content 'Role has been updated.'
    expect(page).to have_content user.email
    within 'table tr', text: user.email do
      expect(page).to have_content('manager')
      expect(page).not_to have_content 'Agent'
      expect(page).not_to have_content 'manager@example.com'
    end

  end
end
