require 'rails_helper'

RSpec.feature 'Users can create agents' do 
  before do
    visit '/'
    click_link 'Agents'
    click_link 'New Agent'

    fill_in 'Id', with: 1
    fill_in 'Name', with: 'Agent no 1'
    click_button 'Create Agent'
  end

  scenario 'with valid attributes' do
    expect(page).to have_content 'Agent has been created.'
  end

  scenario "when providing invalid attributes" do
    visit '/'
    click_link 'Agents'
    click_link 'New Agent'

    fill_in 'Id', with: 1
    fill_in 'Name', with: 'Agent no 1'
    click_button 'Create Agent'
    
    expect(page).to have_content 'Agent has not been created.'
  end
end
