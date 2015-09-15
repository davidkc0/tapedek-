class TagsController < ApplicationController

  def show
    @posts = Post.tagged_with(params[:id]).paginate(page: params[:page], per_page: 8)
  end
end
