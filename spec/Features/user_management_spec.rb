require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature 'User signs in' do
  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'test')
    expect(page).to have_content('Welcome, test@test.com')
  end

  scenario 'with incorrect credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end

feature 'User signs out' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'test')
    click_button 'Sign out'
    expect(page).to have_content('Good bye!')
    expect(page).not_to have_content('Welcome, test@test.com')
    end
end

feature 'User signs up' do

   scenario 'when being a new user visiting the site' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'with a password that does not match' do
    expect { sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Sorry, there were the following problems with the form.')
  end

  def sign_up(email = 'alice@example.com',
              password = 'oranges!',
              password_confirmation = 'oranges!')
    visit 'users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

  scenario 'with an email that is already registered' do
    expect { sign_up }.to change(User, :count).by(1)
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end
end

feature 'User forgets password' do
  before(:each) do
    User.create(email: 'test@test.com', password: 'test', password_confirmation: 'test')
    # this possibly needs to be in scenario after visit without the before each do piece
  end

  scenario 'User requests replacement password' do
    visit '/sessions/new'
    expect(page).to have_content('Forgot password?')
    fill_in :forgot, with: 'test@test.com'
    click_button 'new password'
    expect(page). to have content"Reset token sent - please check your email."
    expect(user.password_token).to be_true
    expect(User).to receive()
    within#{password recovery} do
    # figure out which expect is correct
  end

  scenario 'User resets password' do
    visit '/users/new_password'
    expect(page).to have_content('No need to fear, password recovery is here!')
    fill_in :New_password, with: password
    fill_in :New_password_confirmation, with: password_confirmation
    click_button 'Reset password'
    expect()
  end

end