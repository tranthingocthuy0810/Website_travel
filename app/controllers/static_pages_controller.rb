class StaticPagesController < ApplicationController
  def home
    @posts = policy_scope(Post)
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def help
  end
end

