class StaticPagesController < ApplicationController
  def home
    @posts = policy_scope(Post)
  end

  def show
  end
  
  def help
  end
end
