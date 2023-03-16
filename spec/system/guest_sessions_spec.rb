require 'rails_helper'

RSpec.describe 'GuestSessions', type: :system do
  scenario 'ゲストログインする' do
    visit root_path
    page.first('#login_button').click
    expect(current_path).to eq root_path
    expect(page).to have_content 'ゲストユーザーとしてログインしました'
  end

  scenario 'ゲストログアウトする' do
    guest_login
    expect(current_path).to eq root_path
    click_on 'ログアウト'
    expect(current_path).to eq login_path
    expect(page).to have_content 'ログアウトしました'
  end

  describe 'ゲストユーザー機能制限' do
    let!(:post1) { create(:post, title: '投稿1') }
    before do
      guest_login
    end

    scenario 'アカウント削除ができないこと' do
      visit users_account_path
      click_on '削除'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ゲストユーザーにはこの機能はありません'
    end

    scenario 'アカウント編集ができないこと' do
      visit users_account_path
      click_on '編集'
      click_on '更新'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ゲストユーザーにはこの機能はありません'
    end

    scenario 'プロフィール編集ができないこと' do
      visit users_profile_path
      click_on '更新'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ゲストユーザーにはこの機能はありません'
    end

    scenario '投稿編集ができないこと' do
      visit "/posts/100/edit?post_id=#{post1.id}"
      click_on '更新'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ゲストユーザーにはこの機能はありません'
    end

    scenario '投稿削除ができないこと' do
      visit new_post_path
      fill_in 'post[title]', with: 'クジラ発見'
      attach_file 'post[image]', 'spec/fixtures/post_test_image.jpg'
      select '東京都', from: 'post_place_prefecture'
      fill_in 'post[place_detail]', with: '八丈島底土港'
      fill_in 'post[description]', with: 'ザトウクジラを港で見ました'
      click_on '送信'
      visit '/posts/100/index'
      click_link '削除'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ゲストユーザーにはこの機能はありません'
    end
  end
end
