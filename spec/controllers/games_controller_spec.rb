require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  it 'handles a missing game correctly' do
    get :show, id: 'not-an-id'

    expect(response).to redirect_to games_path

    message = 'The game you were looking for could not be found.'
    expect(flash[:alert]).to eq message
  end
end
