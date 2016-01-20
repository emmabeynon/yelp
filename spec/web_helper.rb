def sign_in
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: 'jane@doe.com'
  fill_in 'Password', with: 'janedoee'
  click_button 'Log in'
end
