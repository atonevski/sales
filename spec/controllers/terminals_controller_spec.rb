require 'rails_helper'

RSpec.describe TerminalsController, type: :controller do
  it 'respnds with JSON' do
    user = FactoryGirl.create :user
    assign_role! user, :viewer, 'Agent'
    allow(controller).to receive(:current_user).and_return(user)

    FactoryGirl.create :agent, id: 1
    FactoryGirl.create :terminal, id: 1, name: 'Terminal 1', tel: 'tel. 1', agent_id: 1
    FactoryGirl.create :terminal, id: 2, name: 'Terminal 2', tel: 'tel. 2', agent_id: 1

    # we need this to make sure policy_scope(Terminals) works correctly
    FactoryGirl.create :terminal, id: 3, name: 'Terminal 3', tel: 'tel. 3', agent_id: 2

    get :index, agent_id: 1, format: :json
    expect(JSON.parse response.body).to eq [ 
      { 'id' => 1, 'name' => 'Terminal 1', 'city' => 'New York', 'tel' => 'tel. 1'}, 
      { 'id' => 2, 'name' => 'Terminal 2', 'city' => 'New York', 'tel' => 'tel. 2'} ]
  end
end
