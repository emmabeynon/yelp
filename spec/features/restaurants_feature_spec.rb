require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
        visit '/restaurants'
        expect(page).to have_content 'No restaurants yet'
        expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before(:context) do
      visit '/users/sign_up'
      fill_in 'Email', with: 'jane@doe.com'
      fill_in 'Password', with: 'janedoee'
      fill_in 'Password confirmation', with: 'janedoee'
      click_button 'Sign up'
      Restaurant.create(name: 'KFC')
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'when signed in' do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'jane@doe.com'
      fill_in 'Password', with: 'janedoee'
      fill_in 'Password confirmation', with: 'janedoee'
      click_button 'Sign up'
    end

    context 'creating restaurants' do
      scenario 'prompts user to fill out a form, then displays the new restaurant' do
        sign_in
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'McDonalds'
        click_button 'Create Restaurant'
        expect(page).to have_content 'McDonalds'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'allows user to upload an image for the restaurant' do
        sign_in
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'McDonalds'
        page.attach_file('Image', Rails.root + 'spec/factories/test.jpg')
        expect(attach_file('Image', 'spec/factories/test.jpg')).to be_truthy
      end

      context 'an invalid restaurant' do
        it 'does not let you submit a name that is too short' do
          sign_in
          visit '/restaurants'
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

    context 'viewing restaurants' do
      let!(:user){User.create(email: 'jane@done.com', password: 'janedoee', password_confirmation: 'janedoee')}
      let!(:restaurant){Restaurant.create(name:'ABC', user: user)}
      scenario 'lets a user view a restaurant' do
        sign_in
        visit '/restaurants'
        click_link 'ABC'
        expect(page).to have_content 'ABC'
        expect(current_path).to eq "/restaurants/#{restaurant.id}"
      end
    end

    context 'editing restaurants' do
      let(:restaurant) { create :restaurant, :first}
      scenario 'lets a user edit a restaurant only if they created it' do
        sign_in
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'McDonalds'
        click_button 'Create Restaurant'
        visit '/'
        click_link 'Edit McDonalds'
        fill_in 'Name', with: 'MaccyD'
        click_button 'Update Restaurant'
        expect(page).to have_content 'MaccyD'
      end

      scenario 'does not let a user edit a restaurant if they did not create it' do
        sign_in
        visit '/'
        click_link 'Edit KFC'
        expect(page).to have_content 'Error: You cannot edit this restaurant as you did not create it'
      end
    end

    context 'deleting restaurants' do
      let(:restaurant) { create :restaurant, :first}
      scenario 'removes a restaurant when a user clicks a delete link' do
        sign_in
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'McDonalds'
        click_button 'Create Restaurant'
        visit '/'
        click_link 'Delete McDonalds'
        expect(page).not_to have_content 'McDonalds'
        expect(page).to have_content 'Restaurant deleted successfully'
      end

      scenario 'prevents users from deleting a restaurant they did not create' do
        sign_in
        visit '/'
        click_link 'Delete KFC'
        expect(page).to have_content 'Error: You cannot delete this restaurant as you did not create it'
      end
    end
  end

  context 'when not signed in' do
    context 'creating restaurants' do
      scenario 'prevents user from adding a restaurant' do
        visit '/'
        click_link 'Add a restaurant'
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
        expect(page).not_to have_button 'Create Restaurant'
      end
    end

    context 'editing restaurants' do
      let(:restaurant) { create :restaurant, :first}
      scenario 'prevents user from editing a restaurant' do
        visit '/'
        expect(page).not_to have_button 'Edit KFC'
      end
    end

    context 'deleting restaurants' do
      let(:restaurant) { create :restaurant, :first}
      scenario 'prevents user from deleting a restaurant' do
        visit '/'
        click_link 'Delete KFC'
        expect(page).to have_content 'You need to sign in or sign up before continuing'
        expect(page).not_to have_button 'Delete Restaurant'
      end
    end
  end

end
