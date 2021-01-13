require 'rails_helper'

RSpec.feature 'Visitor attempts login to application', type: :feature, js: true do

  before :each do
    @user = User.create!({
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password'
    })
  end

  scenario 'User successfully logs into the application' do
    visit root_path

    find_link('Login').click

    expect(page).to have_field 'password', type: 'password'

    within 'form' do
      fill_in name: 'email', with: 'john@example.com'
      fill_in name: 'password', with: 'password'

      click_button 'Submit'
    end

    expect(page).to have_content 'Signed in as John Doe'
  end
end
