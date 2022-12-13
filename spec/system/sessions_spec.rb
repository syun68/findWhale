require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { create(:user) }

  before do
    visit login_path
  end

  scenario 'ログインする' do
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content "こんにちは。#{user.name}さん"
  end
end
