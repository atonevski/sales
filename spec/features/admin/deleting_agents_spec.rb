require 'rails_helper'

RSpec.feature 'Users can delete games' do
  before do
    login_as FactoryGirl.create :user, :admin
  end

  scenario 'successfully' do
    FactoryGirl.create :agent

    visit '/agents'
    click_link 'Agent name'
    click_link 'Delete Agent'

    expect(page).to have_content 'Agent has been deleted.'
    expect(page.current_url).to eq agents_url
    expect(page).to have_no_content 'Agent name'
  end
end
