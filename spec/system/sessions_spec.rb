require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { create(:user) }

  scenario 'ログインする' do
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content "こんにちは。#{user.name}さん"
  end

  scenario 'ログアウトする' do
    login
    expect(current_path).to eq root_path
    click_on 'ログアウト'
    expect(current_path).to eq login_path
    expect(page).to have_content 'ログアウトしました'
  end
end
