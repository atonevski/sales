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
end
