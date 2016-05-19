require 'rails_helper'

RSpec.feature 'An admin can archive users' do
  let(:admin_user) { FactoryGirl.create :user, :admin }
  let(:user) { FactoryGirl.create :user }

  before do
    login_as admin_user
  end

  scenario 'successfully' do
    visit admin_user_path user
    click_link 'Archive User'

    expect(page).to have_content 'User has been archived.'
    within 'table tr', text: user.email do # since we change admin flag
      expect(page).to have_content('Archive')
    end
  end

  scenario 'except themselves' do
    visit admin_user_path admin_user
    click_link 'Archive User'

    expect(page).to have_content 'You cannot archive yourself!'
    within 'table tr', text: admin_user.email do 
      expect(page).not_to have_content('Archive')
    end
  end
end
