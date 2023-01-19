require 'rails_helper'

RSpec.describe "Tops", type: :system do
  let(:user) { create(:user, name: 'user') }
  let!(:post1) { create(:post, title: '投稿1', place_detail: '八丈島', description: 'クジラ') }
  let!(:post2) { create(:post, title: '投稿2', place_detail: '知床', description: 'シャチ') }
  let!(:post3) { create(:post, title: '投稿3', place_detail: '沖縄', description: 'サンゴ') }

  before do
    user.post << post1
    user.post << post2
    user.post << post3
  end

  describe '検索をする' do
    context '存在する投稿のキーワードを検索フォームに入力する' do
      scenario 'キーワードに合う投稿のみが返される' do
        visit root_path
        fill_in 'keyword', with: '八丈島'
        click_on '検索'
        #検索結果一覧ページに遷移していることを確認
        expect(current_path).to eq search_path
        expect(page).to have_content('投稿1')
        expect(page).not_to have_content('投稿2')
        expect(page).not_to have_content('投稿3')
      end
    end

    context '存在しないキーワードを検索フォームに入力する' do
      scenario 'エラーメッセージが表示される' do
        visit root_path
        fill_in 'keyword', with: 'アザラシ'
        click_on '検索'
        #検索結果一覧ページに遷移しておらず、エラーメッセージが表示されていることを確認
        expect(current_path).to eq root_path
        expect(page).to have_content('検索結果がありませんでした')
        expect(page).not_to have_content('投稿1')
        expect(page).not_to have_content('投稿2')
        expect(page).not_to have_content('投稿3')
      end
    end
  end
end
