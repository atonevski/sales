require 'rails_helper'

RSpec.feature 'Admins can create new users' do
  let(:admin) { FactoryGirl.create :user, :admin }
  
  before do
    login_as admin
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link 'New User'
  end

  scenario 'with valid credentials' do
    fill_in 'Email', with: 'newuser@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Create User'

    expect(page).to have_content 'User has been created.'
    expect(page).to have_content 'newuser@example.com'
    within 'table tr', text: 'newuser@example.com' do
      expect(page).not_to have_content('Admin')
    end

    user = User.find_by_email 'newuser@example.com'
    expect(Role.where(user_id: user.id).count).to eq 2
  end

  scenario 'when new user is an admin' do
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    check 'Is an admin?'
    click_button 'Create User'

    expect(page).to have_content 'User has been created.'
    expect(page).to have_content 'admin@example.com'
    within 'table tr', text: 'admin@example.com' do
      expect(page).to have_content('Admin')
    end
  end
end
