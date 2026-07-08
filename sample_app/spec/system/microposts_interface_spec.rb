require 'rails_helper'

RSpec.feature 'Microposts'do
  let(:user){users(:michael)}

  background do
    visit login_path
    fill_in 'Email',with: user.email
    fill_in 'Password',with: 'password'

    click_button 'Log in'
  end

  context 'microposts interface test' do
    scenario 'should paginate' do
      visit root_path
      # page.save_screenshot
      expect(page).to have_link "Next →"
    end

    scenario 'should show errors but not create micropost on invalid submission' do
      visit root_path

      fill_in 'Compose new micropost...', with: ""
      click_button 'Post'

      expect(page).to have_content "error" 
    end
    
    scenario 'should create a micropost on valid submission' do
      visit root_path
      content = "This micropost really ties the room together"

      fill_in 'micropost_content',with: content

      expect{click_button 'Post'}.to change{Micropost.count}.by(1)

      expect(current_path).to eq root_path
      expect(page).to have_content content
    end

    scenario 'should have micropost delete links on own profile page' do
      visit user_path(user)
      expect(page).to have_link 'delete'
      expect {
        click_link 'delete', match: :first
      }.to change(Micropost, :count).by(-1)
    end

  end
end
