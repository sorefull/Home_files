class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
  end

  def new
    @post = current_user.posts.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, :notice => "Your post was succesfully created."
    else
      redirect_to new_post_path, alert: @post.errors["title"].first
    end
  end

  def destroy
    if current_user.admin? || current_user == Post.find(params[:id]).user
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path, alert: "Your post was succesfully deleted!"
    else
      redirect_to posts_path, alert: "Unable for you."
    end
  end

  def about
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end