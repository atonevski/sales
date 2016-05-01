require 'rails_helper'

RSpec.feature 'Users can delete games' do
  scenario 'successfully' do
    FactoryGirl.create :game, name: 'Ново Лото 7/34'

    visit '/'
    click_link 'Ново Лото 7/34'
    click_link 'Delete Game'

    expect(page).to have_content 'Game has been deleted.'
    expect(page.current_url).to eq games_url
    expect(page).to have_no_content 'Ново Лото 7/34'
  end
end
