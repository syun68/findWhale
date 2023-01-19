class SearchController < ApplicationController

  def search
    gon.map_key = ENV['Google_Map_API']
    @posts = Post.search(params[:keyword])
      if @posts.count == 0
        flash[:notice] = '検索結果がありませんでした'
        redirect_to root_path
      elsif params[:sort_update]
        @posts = Post.search(params[:keyword]).latest
      end
  end

end
