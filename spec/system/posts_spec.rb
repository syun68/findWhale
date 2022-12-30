require 'rails_helper'

RSpec.describe 'Posts', js: true, type: :system do
  let(:user) { create(:user, name: 'user') }
  let(:other_user) { create(:user, name: 'other_user') }
  let!(:post1) { create(:post, title: '投稿1') }
  let!(:post2) { create(:post, title: '投稿2') }

  before do
    driven_by(:rack_test)
    user.post << post1
    user.post << post2
    # ログイン専用ページをテストするため、最初にログイン
    login
  end

  describe '新規投稿をする' do
    context '入力値が正常' do
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

  describe '投稿編集一覧ページ' do
    context 'user is not equal to current_user' do
      scenario 'エラーメッセージが表示され、トップページに遷移する' do
        visit "/posts/#{other_user.id}/index"
        expect(current_path).to eq root_path
        expect(page).to have_content('詳細情報を入力してください')
      end
    end

    context 'user is equal to current_user' do
      scenario '投稿編集一覧ページが表示される' do
        visit "/posts/#{user.id}/index"
        expect(current_path).to eq "/posts/#{user.id}/index"
      end

      scenario 'ログインユーザーの投稿した一覧が表示される' do
        visit "/posts/#{user.id}/index"
        expect(page).to have_content(post1.title)
        expect(page).to have_selector("img[src$='post_test_image.jpg']")
        expect(page).to have_content(post1.created_at.strftime('%Y/%m/%d %H:%M'))
        expect(page).to have_content(post1.place_prefecture)
        expect(page).to have_content(post1.place_detail)
        expect(page).to have_content(post1.description)
        expect(page).to have_content(post2.title)
        expect(page).to have_selector("img[src$='post_test_image.jpg']")
        expect(page).to have_content(post2.created_at.strftime('%Y/%m/%d %H:%M'))
        expect(page).to have_content(post2.place_prefecture)
        expect(page).to have_content(post2.place_detail)
        expect(page).to have_content(post2.description)
      end

      scenario '編集ボタンをクリックする' do
        visit "/posts/#{user.id}/index"
        within '#post_edit_link_container', match: :first do
          click_on '編集'
          expect(page).to have_current_path edit_post_path(id: user.id, post_id: post1.id)
        end
      end

      # scenario '削除ボタンをクリックする' do
      #   visit "/posts/#{user.id}/index"
      #   within '#post_edit_link_container', match: :first do
      #     click_on '削除', match: :first
      #     # expect{
      #       expect(page.accept_confirm).to eq '本当に削除しますか？'
      #       expect(page).to have_content '投稿を削除しました'
      #       sleep 0.5
      #     # }. to change(user.post, :count).by(-1)
      #   end
      # end
    end
  end

  describe '投稿編集ページ' do
    scenario '投稿編集ページへアクセスする' do
      visit "/posts/#{user.id}/edit?post_id=#{post1.id}"
      expect(page).to have_current_path edit_post_path(id: user.id, post_id: post1.id)
    end

    scenario '投稿編集ページが表示される' do
      visit "/posts/#{user.id}/edit?post_id=#{post1.id}"
      expect(page).to have_content('投稿編集')
      expect(page).to have_content('タイトル')
      expect(page).to have_field('post[title]', with: post1.title)
      expect(page).to have_content('画像')
      expect(page).to have_selector("img[src$='post_test_image.jpg']")
      expect(page).to have_content('発見場所')
      expect(page).to have_field('post[place_prefecture]', with: post1.place_prefecture)
      expect(page).to have_content('発見場所（詳細位置）')
      expect(page).to have_field('post[place_detail]', with: post1.place_detail)
      expect(page).to have_content('状況詳細（自由記述）')
      expect(page).to have_field('post[description]', with: post1.description)
    end
  end

  describe '投稿編集をする' do
    context '入力値が正常' do
      scenario '投稿の編集が成功する' do
        visit "/posts/#{user.id}/edit?post_id=#{post1.id}"
        fill_in 'post[title]', with: 'edit post title'
        post1.image.attach(
          io: File.open('spec/fixtures/user_test_image.png'),
          filename: 'user_test_image.png'
        )
        select '北海道', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: '羅臼'
        fill_in 'post[description]', with: '目撃情報を更新しました'
        click_on '更新'
        # 投稿一覧ページに遷移していることを確認
        expect(current_path).to eq "/posts/#{user.id}/index"
        expect(page).to have_content('投稿を更新しました')
        # 更新内容が反映されていることを確認
        expect(post1.reload.title).to eq 'edit post title'
        expect(page).to have_selector("img[src$='user_test_image.png']")
        expect(post1.reload.place_prefecture).to eq '北海道'
        expect(post1.reload.place_detail).to eq '羅臼'
        expect(post1.reload.description).to eq '目撃情報を更新しました'
      end
    end

    context 'タイトルを未記入で更新' do
      scenario '投稿の更新が失敗する' do
        visit "/posts/#{user.id}/edit?post_id=#{post1.id}"
        fill_in 'post[title]', with: nil
        post1.image.attach(
          io: File.open('spec/fixtures/user_test_image.png'),
          filename: 'user_test_image.png'
        )
        select '北海道', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: '羅臼'
        fill_in 'post[description]', with: '目撃情報を更新しました'
        click_on '更新'
        expect(page).to have_content('更新に失敗しました 入力値が空欄になっていませんか？')
      end
    end

    context '都道府県を未記入で更新' do
      scenario '投稿の更新が失敗する' do
        visit "/posts/#{user.id}/edit?post_id=#{post1.id}"
        fill_in 'post[title]', with: 'edit post title'
        post1.image.attach(
          io: File.open('spec/fixtures/user_test_image.png'),
          filename: 'user_test_image.png'
        )
        select '---', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: '羅臼'
        fill_in 'post[description]', with: '目撃情報を更新しました'
        click_on '更新'
        expect(page).to have_content('目撃場所の都道府県を選択してください')
      end
    end

    context '発見場所（詳細位置）を未記入で更新' do
      scenario '投稿の更新が失敗する' do
        visit "/posts/#{user.id}/edit?post_id=#{post1.id}"
        fill_in 'post[title]', with: 'edit post title'
        post1.image.attach(
          io: File.open('spec/fixtures/user_test_image.png'),
          filename: 'user_test_image.png'
        )
        select '北海道', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: nil
        fill_in 'post[description]', with: '目撃情報を更新しました'
        click_on '更新'
        expect(page).to have_content('更新に失敗しました 入力値が空欄になっていませんか？')
      end
    end

    context '状況詳細（自由記述）を未記入で更新' do
      scenario '投稿の更新が失敗する' do
        visit "/posts/#{user.id}/edit?post_id=#{post1.id}"
        fill_in 'post[title]', with: 'edit post title'
        post1.image.attach(
          io: File.open('spec/fixtures/user_test_image.png'),
          filename: 'user_test_image.png'
        )
        select '北海道', from: 'post_place_prefecture'
        fill_in 'post[place_detail]', with: nil
        fill_in 'post[description]', with: nil
        click_on '更新'
        expect(page).to have_content('更新に失敗しました 入力値が空欄になっていませんか？')
      end
    end
  end
end
