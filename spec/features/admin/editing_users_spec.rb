require 'rails_helper'

RSpec.feature "Admins can change user's details" do
 let(:admin_user) { FactoryGirl.create :user, :admin }
 let(:user) { FactoryGirl.create :user }

  before do
    login_as admin_user
    visit admin_user_path(user)
    click_link 'Edit User'
  end

  scenario 'with vaild details' do
    fill_in 'Email', with: 'newuser@example.com'
    click_button 'Update User'

    expect(page).to have_content 'User has been updated.'
    expect(page).to have_content 'newuser@example.com'
    expect(page).not_to have_content user.email
  end

  scenario "when toggling a user's admin ability" do
    check'Is an admin?'
    click_button 'Update User'

    expect(page).to have_content 'User has been updated.'
    within 'table tr', text: user.email do # since we change admin flag
      expect(page).to have_content('Admin')
    end
  end
end
