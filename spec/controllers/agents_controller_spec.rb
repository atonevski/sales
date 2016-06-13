require 'rails_helper'

RSpec.describe AgentsController, type: :controller do
  it 'handles a missing game correctly' do
    get :show, id: 'not-an-id'

    expect(response).to redirect_to agents_path

    message = 'The agent you were looking for could not be found.'
    expect(flash[:alert]).to eq message
  end

  it 'handles permission errors by redirecting to a safe location' do
    allow(controller).to receive(:current_user)

    agent = FactoryGirl.create :agent
    get :show, id: agent

    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq "You aren't allowed to do that."
  end

  it 'respnds with JSON' do
    # allow(controller).to receive(:current_user)
    user = FactoryGirl.create :user
    assign_role! user, :viewer, 'Agent'
    allow(controller).to receive(:current_user).and_return(user)

    FactoryGirl.create :agent, id: 1, name: 'Agent 1'
    FactoryGirl.create :agent, id: 2, name: 'Agent 2'

    get :index, format: :json
    expect(JSON.parse response.body).to eq [ 
      { 'id' => 1, 'name' => 'Agent 1', 'terminals' => [] }, 
      { 'id' => 2, 'name' => 'Agent 2', 'terminals' => [] } ]
  end
end
