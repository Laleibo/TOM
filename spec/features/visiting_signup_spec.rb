require 'rails_helper'

feature 'Visiting the Profile Page' do

  # it 'displays a link to login' do
  #   visit profile_path
  #   find_link 'Log In'
  # end

  it 'shows a sign up/profile new form' do
    visit '/register'
    find_field 'Email'
    find_field 'Password'
    find_field 'address1'
    find_field 'address2'
    find_field 'city'
    find_field 'state'
    find_field 'zip'
    find_button 'Submit'
  end

  it 'submitting that form logs a Profile in' do
    visit root_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'submit'
    expect(current_path).to eq(root_path)
  end
end
