require 'rails_helper'

describe 'User - Profile - Update' do
  let(:user) { create(:user, password: 'Password1!') }

  before do
    login_as user
    visit user_profile_path
  end

  it 'updates profile' do
    fill_in 'user_first_name', with: 'NewName'
    fill_in 'user_last_name', with: 'NewLastName'
    click_on 'Update'

    user.reload
    expect(user.first_name).to eq 'NewName'
    expect(user.last_name).to eq 'NewLastName'
  end

  it 'updates email' do
    fill_in 'user_email', with: 'new@example.com'
    fill_in 'user_current_password', with: 'Password1!'
    click_on 'Change'

    user.reload
    expect(user.email).to eq 'new@example.com'
  end

  it 'updates password' do
    click_on 'Reset Password'
    expect(page).to have_css '#modal_reset_password'

    within '#modal_reset_password' do
      fill_in 'user_reset_current_password', with: 'Password1!'
      fill_in 'user_password', with: 'Password1!!'
      fill_in 'user_password_confirmation', with: 'Password1!!'
      click_on 'Update password'
    end

    user.reload
    expect(user.errors).to be_blank
    expect(user.password).to be_present
  end
end
