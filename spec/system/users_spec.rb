require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  before do
    # ログイン専用ページをテストするため、最初にログイン
    login
  end

  describe 'アカウント設定' do
    before do
      visit users_account_path
    end

    scenario 'アカウント設定画面を表示する' do
      expect(page).to have_content('メールアドレス')
      expect(page).to have_content(user.email)
      expect(page).to have_content('パスワード')
      expect(page).to have_content('********')
    end

    scenario 'アカウント設定をする' do
      visit users_account_path
      click_on '編集'
      # アカウント設定ページに飛び、ユーザーのメールアドレスが表示されていることを確認
      expect(current_path).to eq "/users/#{user.id}/edit"
      expect(page).to have_content('メールアドレス')
      expect(page).to have_field('user[email]', with: user.email)
      # パスワードを変更
      fill_in 'user[password]', with: 'afterpassword'
      fill_in 'user[password_confirmation]', with: 'afterpassword'
      fill_in 'user[current_password]', with: user.password
      click_on '更新'
      # プロフィールページに遷移され、フラッシュが表示されていることを確認
      expect(current_path).to eq users_profile_path
      expect(page).to have_content('ユーザー情報を更新しました')
      # パスワードが更新されていることを確認
      expect(user.reload.current_password).to eq user.authenticate('afterpassword').password_digest
    end

    scenario 'アカウントを削除する' do
      click_on '削除'
      expect(current_path).to eq root_path
      expect(page).to have_content('アカウントを削除しました')
    end
  end

  describe 'プロフィール設定' do
    scenario 'プロフィール設定をする' do
      # プロフィール設定ページへ訪れる
      visit users_profile_path
      expect(current_path).to eq users_profile_path
      # ラベル名が表示されていることを確認
      expect(page).to have_content('アイコン画像')
      expect(page).to have_content('名前')
      expect(page).to have_content('自己紹介')
      # 入力フォームに名前が入っていることを確認
      expect(page).to have_field('user[name]', with: user.name)
      # 名前、自己紹介を更新
      user.avatar.attach(
        io: File.open('spec/fixtures/user_test_image.png'),
        filename: 'user_test_image.png'
      )
      fill_in 'user[name]', with: 'aftername'
      fill_in 'user[introduction]', with: 'hello world!'
      click_on '更新'
      # トップページに遷移していることを確認
      expect(current_path).to eq root_path
      expect(page).to have_content('プロフィール情報を更新しました')
      # 名前、自己紹介が更新されていることを確認
      expect(user.reload.avatar.filename).to eq 'user_test_image.png'
      expect(user.reload.name).to eq 'aftername'
      expect(user.introduction).to eq 'hello world!'
      # headerのアイコン画像が更新されていることを確認
      within '.hamburger-menu' do
        expect(page).to have_selector("img[src$='user_test_image.png']")
      end
      # 再度、プロフィール設定ページへ訪れ、設定画像が表示されていることを確認
      expect(page).to have_selector("img[src$='user_test_image.png']")
    end
  end
end
