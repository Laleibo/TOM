require 'rails_helper'

feature 'Visiting the Registration Page' do

  it 'displays a link to login' do
    visit profile_path
    find_link 'Log In'
  end

  it 'shows a registration form' do
    visit profile_path
    find_field 'Email'
    find_field 'Password'
    find_button 'Register'
  end

  it 'submitting that form logs a Profile in' do
    visit profile_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Register'
    expect(current_path).to eq(root_path)
  end
end
