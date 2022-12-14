require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post create' do
    let(:post) { create(:post) }

    it 'is valid with title, image, place_prefecture, place_detail, description' do
      expect(post).to be_valid
    end

    context 'without necessary items' do
      it 'is invalid without title' do
        post = Post.new(title: nil)
        post.valid?
        expect(post.errors[:title]).to include('を入力してください')
      end

      it 'is invalid without image' do
        post = Post.new(image: nil)
        post.valid?
        expect(post.errors[:image]).to include('を入力してください')
      end

      it 'is invalid without place_detail' do
        post = Post.new(place_detail: nil)
        post.valid?
        expect(post.errors[:place_detail]).to include('を入力してください')
      end

      it 'is invalid without description' do
        post = Post.new(description: nil)
        post.valid?
        expect(post.errors[:description]).to include('を入力してください')
      end
    end
  end
end
