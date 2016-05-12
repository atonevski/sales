require 'rails_helper'

RSpec.feature 'Users can edit terminals' do
  let(:agent) { FactoryGirl.create :agent }
  let(:terminal) { FactoryGirl.create :terminal, agent_id: agent.id }

  before do
    visit agent_terminal_path agent, terminal
    click_link 'Edit Terminal'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Terminal no. 2'
    click_button 'Update Terminal'

    expect(page).to have_content 'Terminal has been updated.'

    # check within clause... 
    within '#name' do
      expect(page).to have_content 'Terminal no. 2'
      expect(page).not_to have_content terminal.name
    end
  end

  scenario 'with invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Terminal'

    expect(page).to have_content 'Terminal has not been updated.'
  end
end
