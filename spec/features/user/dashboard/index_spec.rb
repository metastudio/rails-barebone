require 'rails_helper'

describe 'Dashboard - Index' do
  let(:user) { create(:user) }

  before do
    login_as user
    visit user_dashboard_path
  end

  it 'show dashboard' do
    expect(page).to have_content 'Dashboard'
  end
end
