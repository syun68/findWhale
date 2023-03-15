require 'rails_helper'

RSpec.describe "GuestSessions", type: :system do

  scenario 'ゲストログインする' do
    visit root_path
    page.first("#login_button").click
    expect(current_path).to eq root_path
    expect(page).to have_content "ゲストユーザーとしてログインしました"
  end

  scenario 'ゲストログアウトする' do
    guest_login
    expect(current_path).to eq root_path
    click_on 'ログアウト'
    expect(current_path).to eq login_path
    expect(page).to have_content 'ログアウトしました'
  end
end
