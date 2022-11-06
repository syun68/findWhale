class MapsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
  end
end
