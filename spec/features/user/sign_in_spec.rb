require 'rails_helper'

describe 'Users - Sign In' do
  let(:user) { create(:user, password: 'Password1!') }

  before do
    visit new_user_session_path
  end

  it 'sign in successfully' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'Password1!'
    click_on 'Login'

    expect(page).to have_content 'My Account'
    expect(page).to have_current_path(root_path)
  end

  it 'returns error if has invalid email' do
    fill_in 'user_email', with: 'bademail@'
    fill_in 'user_password', with: 'Password1!'
    click_on 'Login'

    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'returns error if has invalid password' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'incorrect'
    click_on 'Login'

    expect(page).to have_content 'Invalid Email or password.'
  end

  context 'with deactivated status' do
    let(:user) { create(:user, password: 'Password1!', deactivated_at: Time.current) }

    it 'returns error' do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'Password1!'
      click_on 'Login'

      expect(page).to have_content 'Your account is not activated yet.'
    end
  end
end
