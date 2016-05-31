require 'rails_helper'

RSpec.feature 'Users can view agents' do
  let(:user) { FactoryGirl.create :user }
  let!(:agent) { FactoryGirl.create :agent }

  before do
    # login_as user
    # assign_role! user, :viewer, agent.class.name.singularize.camelize
  end

  scenario 'with the agent details' do
    login_as user
    assign_role! user, :viewer, agent.class.name.singularize.camelize

    visit agents_path

    click_link agent.name # factory girl default attribute
    expect(page.current_url).to eq agent_url(agent)
  end

  scenario 'unless they have permissions' do
   
    visit agents_path
    expect(page).not_to have_content agent.name
  end
end
