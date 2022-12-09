require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  before do
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'
  end

  scenario 'アカウント設定をする' do
    visit users_account_path
    expect(page).to have_content('メールアドレス')
    expect(page).to have_content(user.email)
  end
end
