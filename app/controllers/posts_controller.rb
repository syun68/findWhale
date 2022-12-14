class PostsController < ApplicationController
  before_action :logged_in_user

  def index
    gon.map_key = ENV['Google_Map_API']
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      **post_params,
      user_id: @current_user.id
    )
    if params[:post][:place_prefecture] == '---'
      flash[:notice] = '目撃場所の都道府県を選択してください'
      render 'posts/new', status: :unprocessable_entity
    elsif @post.save
      flash[:notice] = '目撃情報を投稿しました'
      redirect_to :posts
    else
      render 'posts/new', status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit_index
    @posts = Post.where(user_id: params[:id])
    flash[:notice] = '検索結果がありません' if @posts.blank?
  end

  def edit
    @post = Post.find(params[:post_id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:place_prefecture] == '---'
      flash[:notice] = '目撃場所の都道府県を選択してください'
      render 'posts/edit', status: :unprocessable_entity
    elsif @post.update(post_params)
      flash[:notice] = '投稿を更新しました'
      redirect_to "/posts/#{@current_user.id}/index"
    else
      @post = Post.new(post_params)
      flash[:notice] = '更新に失敗しました'
      render 'posts/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to "/posts/#{@current_user.id}/index"
  end

  private

  def post_params
    params
      .require(:post)
      .permit(:title, :image, :place_prefecture, :place_detail, :description, :latitude, :longitude)
  end
end
