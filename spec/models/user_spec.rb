require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User create' do
    it 'is valid with name, an email, password' do
      user = User.new(
        name: 'foo',
        email: 'foo@example.com',
        password: 'hogehoge'
      )
      expect(user).to be_valid
    end

    context 'without necessary items' do
      it 'is invalid without name' do
        user = User.new(name: nil)
        user.valid?
        expect(user.errors[:name]).to include('を入力してください')
      end

      it 'is invalid without email' do
        user = User.new(email: nil)
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end

      it 'is invalid without password' do
        user = User.new(password: nil)
        user.valid?
        expect(user.errors[:password]).to include('を入力してください')
      end
    end

    it 'is invalid with too short password' do
      user = User.new(password: 'hoge')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end

    it 'is invalid with invalid password_confirmation' do
      user = User.new(
        password: 'hogehoge',
        password_confirmation: 'foofoo'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end
  end
end
