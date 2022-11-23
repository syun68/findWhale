require 'rails_helper'

RSpec.describe "Maps", type: :request do
  describe "GoogleMap が表示されているページへのアクセス" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, place_detail: '八丈島 底土港') }

    context "GoogleMap の動作確認", js: true do
      before do
        get map_path(post.id)
      end

      it '正常なレスポンスが返されること' do
        expect(response).to have_http_status(:success)
      end 
    end
  end
end
