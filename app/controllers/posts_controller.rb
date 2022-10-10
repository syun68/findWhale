class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
      if @post.save
        flash[:notice] = "目撃情報を投稿しました"
        redirect_to "/"
      else
        render 'posts/new',  status: :unprocessable_entity
      end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def post_params
      params.require(:post).permit(:title, :image, :place_prefecture, :place_detail, :description)
    end
end
