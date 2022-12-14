require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }

  before do
    # ログイン専用ページをテストするため、最初にログイン
    login
  end

  describe '新規投稿をする' do
    context '入力フォームが正常' do
      scenario '投稿の新規作成が成功する' do
        visit new_post_path
        fill_in 'post[title]', with: 'クジラ発見'
        attach_file 'post[image]', 'spec/fixtures/post_test_image.jpg'
        select '東京都', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: '八丈島底土港'
        fill_in 'post[description]', with: 'ザトウクジラを港で見ました'
        click_on '送信'
        # 投稿一覧ページに遷移していることを確認
        expect(current_path).to eq posts_path
        expect(page).to have_content('目撃情報を投稿しました')
      end
    end

    context 'タイトルが未記入' do
      scenario '投稿の新規作成が失敗する' do
        visit new_post_path
        fill_in 'post[title]', with: nil
        attach_file 'post[image]', 'spec/fixtures/post_test_image.jpg'
        select '東京都', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: '八丈島底土港'
        fill_in 'post[description]', with: 'ザトウクジラを港で見ました'
        click_on '送信'
        # エラーメッセージが表示されることを確認
        expect(page).to have_content('タイトルを入力してください')
      end
    end

    context '画像が未選択' do
      scenario '投稿の新規作成が失敗する' do
        visit new_post_path
        fill_in 'post[title]', with: 'クジラ発見'
        select '東京都', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: '八丈島底土港'
        fill_in 'post[description]', with: 'ザトウクジラを港で見ました'
        click_on '送信'
        # エラーメッセージが表示されることを確認
        expect(page).to have_content('画像を入力してください')
      end
    end

    context '発見した都道府県が未選択' do
      scenario '投稿の新規作成が失敗する' do
        visit new_post_path
        fill_in 'post[title]', with: 'クジラ発見'
        attach_file 'post[image]', 'spec/fixtures/post_test_image.jpg'
        fill_in 'post[place_detail]', with: '八丈島底土港'
        fill_in 'post[description]', with: 'ザトウクジラを港で見ました'
        click_on '送信'
        # エラーメッセージが表示されることを確認
        expect(page).to have_content('目撃場所の都道府県を選択してください')
      end
    end

    context '詳細場所が未記入' do
      scenario '投稿の新規作成が失敗する' do
        visit new_post_path
        fill_in 'post[title]', with: 'クジラ発見'
        attach_file 'post[image]', 'spec/fixtures/post_test_image.jpg'
        select '東京都', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: nil
        fill_in 'post[description]', with: 'ザトウクジラを港で見ました'
        click_on '送信'
        # エラーメッセージが表示されることを確認
        expect(page).to have_content('詳細場所を入力してください')
      end
    end

    context '詳細情報が未記入' do
      scenario '投稿の新規作成が失敗する' do
        visit new_post_path
        fill_in 'post[title]', with: 'クジラ発見'
        attach_file 'post[image]', 'spec/fixtures/post_test_image.jpg'
        select '東京都', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: '八丈島底土港'
        fill_in 'post[description]', with: nil
        click_on '送信'
        # エラーメッセージが表示されることを確認
        expect(page).to have_content('詳細情報を入力してください')
      end
    end
  end
end
