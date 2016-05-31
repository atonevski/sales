require 'rails_helper'

RSpec.feature 'Users can create new terminals' do
  before do
    user  = FactoryGirl.create :user
    agent = FactoryGirl.create :agent, name: 'Agent no. 1'
    assign_role! user, :manager, 'Agent'
    login_as user
    
    visit agent_path(agent)
    click_link 'New Terminal'
  end

  scenario 'with valid attributes' do
    fill_in :id, with: 1
    fill_in :name, with: 'Terminal no. 1'
    fill_in :city, with: 'New York'
    fill_in :address, with: 'Street no. 1'
    fill_in :tel, with: '111-222-124'
    fill_in :lat, with: 41.994839
    fill_in :lng, with: 21.433391

    click_button 'Create Terminal'
    expect(page).to have_content 'Terminal has been created.'
  end

  scenario 'when providing invalid attributes' do
    FactoryGirl.create :terminal, id: 1, name: 'Terminal no. 1'

    fill_in :name, with: 'Terminal no. 1' # simulate non-uniqueness
    click_button 'Create Terminal'

    expect(page).to have_content 'Terminal has not been created.'
    expect(page).to have_content "Id can't be blank"
    expect(page).to have_content "Name has already been taken"
  end
end

#Rails generate model terminal name:string city:string address:string tel:string lat:decimal{12.9} lng:decimal{12.9} agent:references
