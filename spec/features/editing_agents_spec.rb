require 'rails_helper'

RSpec.feature 'Users can edit existing agents' do
  let!(:agent) { FactoryGirl.create :agent, name: 'Agent no. 1' }
  let(:user) { FactoryGirl.create :user }

  before do
    assign_role! user, :editor, 'Agent'
    login_as user

    visit '/'
    click_link 'Agents'
    click_link 'Agent no. 1'
    click_link 'Edit Agent'
  end

  scenario 'with valid attributes' do

    fill_in 'Name', with: 'Agent ONE'
    click_button 'Update Agent'

    expect(page).to have_content 'Agent has been updated.'
    expect(page).to have_content 'Agent ONE'
  end

  scenario 'when providing invalid attributes' do
    # duplicate name
    fill_in 'Name', with: ''
    click_button 'Update Agent'

    expect(page).to have_content 'Agent has not been updated.'
  end
end
