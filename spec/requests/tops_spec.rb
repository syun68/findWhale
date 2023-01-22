require 'rails_helper'

RSpec.describe 'Tops', type: :request do
  describe 'トップページへのアクセス' do
    it '正常なレスポンスが返されること' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
