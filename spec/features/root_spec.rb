require 'rails_helper'

feature 'Visting Root (Profile#show)' do
  it 'when not logged in redirects to home (login page)' do
    visit root_path
    expect(current_path).to eq('/login')
  end

  it 'when logged you see the profile show page' do
    visit root_path
    expect(current_path).to eq('/profiles')
  end
end
