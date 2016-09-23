class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
  end

  def new
    @post = current_user.posts.new
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, :notice => "Your post was succesfully created."
    else
      redirect_to new_post_path, alert: "Error in #{@post.errors.first[0]}: #{@post.errors.first[1]}"
    end
  end

  def destroy
    binding.pry
    if current_user == @post.user
      id = @post.id
      @post.destroy
      FileUtils.rm_rf("public/uploads/post/image/#{id}")
      redirect_to posts_path, alert: "Your post was succesfully deleted!"
    else
      redirect_to posts_path, alert: "Unable for you."
    end
  end

  def about
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :image)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
