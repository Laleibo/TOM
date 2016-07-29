require 'rails_helper'

feature 'Visiting the Home Page' do
  it 'shows a login form' do
    visit root_path
    find_field 'Email'
    find_field 'Password'
    find_button 'Login'
  end

  it 'and submitting that form logs a user in' do
    user = User.create(email: 'john@example.com', password: 'password')
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
    expect(current_path).to eq(profile_path)
  end
end
