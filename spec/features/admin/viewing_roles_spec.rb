require 'rails_helper'

RSpec.feature 'Admins can view roles' do
  let(:admin) { FactoryGirl.create :user, :admin }

  before do
    login_as admin

    viewer  = FactoryGirl.create :user, id: 2, email: 'viewer@example.com'
    editor  = FactoryGirl.create :user, id: 3, email: 'editor@example.com'
    manager = FactoryGirl.create :user, id: 4, email: 'manager@example.com'
    
    vrole   = FactoryGirl.create :role, :viewer 
    erole   = FactoryGirl.create :role, :editor 
    mrole   = FactoryGirl.create :role, :manager 

    visit root_path
    click_link 'Admin'
    click_link 'Roles'
  end

  scenario 'with valid attributes' do
    expect(page).to have_link('viewer@example.com')
    expect(page).to have_link('editor@example.com')
    expect(page).to have_link('manager@example.com')
  end

  scenario 'and single role' do
    click_link 'viewer@example.com'
    
    expect(page).not_to have_content('editor@example.com')

    within '#user_id' do
      expect(page).to have_content '2'
    end
  end
end
