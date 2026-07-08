require 'rails_helper'

RSpec.feature 'user login' do
  let(:user){users(:michael)}

  context 'Invalid Password' do
    scenario 'login with valid email/invalid password' do
      visit login_path
      fill_in 'Email',with: user.email
      fill_in 'Password',with:'invalid'

      click_button 'Log in'

      expect(current_path).to eq login_path
      expect(page).to have_content "Invalid email/password combination"

      visit current_path
      expect(page).to_not have_content "Invalid email/password combination"
    end
  end

  context 'Valid Password' do
    scenario 'valid login and redirect after login' do
      visit login_path
      fill_in 'Email',with: user.email
      fill_in 'Password',with: 'password'

      click_button 'Log in'

      expect(current_path).to eq user_path(user)

      expect(page).not_to have_link "Log in", href: login_path
      expect(page).to have_link "Log out", href: logout_path
      expect(page).to have_link "Profile", href: user_path(user)
    end

    scenario 'log out' do
      visit login_path
      fill_in 'Email',with: user.email
      fill_in 'Password',with: 'password'

      click_button 'Log in'

      click_on 'Account'
      click_on 'Log out'

      expect(current_path).to eq root_path
      expect(page).to have_link "",href: login_path
      expect(page).to_not have_link "",href: logout_path
      expect(page).to_not have_link "",href: user_path(user)
    end
  end
end
