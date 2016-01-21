require 'rails_helper'

feature 'endorsing reviews' do
  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    kfc = Restaurant.new(name: 'KFC')
    kfc.save(validate: false)
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
    visit "/restaurants/#{kfc.id}"
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end
end
