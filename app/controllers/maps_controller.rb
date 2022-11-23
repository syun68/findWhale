# frozen_string_literal: true

class MapsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
end
