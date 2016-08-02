require 'rails_helper'


it 'and submitting the deliver form saves preferences' do
  Profile = Profile.create(profile_id: 1, email: 'john@example.com', password: 'password', address1: 'xyz street', adress2: 'Apt 1', city: "Miami", state: "FL", zip: "33139", delivery: "2016/09/15")
  visit profile_delivery_path(@profile)
  fill_in 'Address1', with: profile.address1
  fill_in 'Address2', with: profile.address2
  fill_in 'city', with: profile.city
  fill_in 'state', with: profile.state
  fill_in 'zip', with: profile.zip
  fill_in 'delivery', with: profile.delivery
  click_button 'update'
  expect(current_path).to eq(profile_delivery_path)(@profile)
end

it 'should have Stripe Pay Button' do
  Profile = Profile.create(profile_id: 1, email: 'john@example.com', password: 'password', address1: 'xyz street', adress2: 'Apt 1', city: "Miami", state: "FL", zip: "33139", delivery: "2016/09/15")
  visit profile_delivery_path(@profile)
  click_button 'Pay with card'
  expect(current_path).to eq(create_charges_path)
end

zip code needs to be exactly 5 numbers
delivery date needs to be atleast 7 days from current date
