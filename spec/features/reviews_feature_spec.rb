require 'rails_helper'

feature 'reviewing' do
  let!(:user) {User.create(email: 'john@doe.com', password: 'johndoee', password_confirmation: 'johndoee')}
  let!(:restaurant) {Restaurant.create(name: 'ABC', user: user)}
  let!(:review) {Review.create(user: user, restaurant: restaurant, rating: 1)}

  scenario 'allows users to leave a review using a form' do
    sign_in
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'prevents user from leaving more than one review per restaurant' do
    sign_in
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    click_button 'Leave Review'
    expect(page).to have_content "You have already reviewed this restaurant"
  end

  scenario 'prevents user from deleting other users\' reviews' do
    sign_in
    visit '/restaurants'
    click_link 'ABC'
    click_link 'Delete Review'
    expect(page).to have_content 'You cannot delete a review you did not write'
  end

  scenario 'displays an average rating for all reviews' do
    sign_up
    sign_in
    leave_review('So so', '3')
    click_link 'Sign out'
    sign_up('john@doe.com','johndoee')
    sign_in('john@doe.com','johndoee')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end


end
