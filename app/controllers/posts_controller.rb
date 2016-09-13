class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
  end

  def new
    @post = current_user.posts.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def set_to_about_welcome
    old_post = Post.find_by(about_welcome: true)
    if old_post
      old_post.about_welcome = false
      old_post.save
    end
    @post = Post.find(params[:id])
    @post.about_welcome = true
    if @post.save
      redirect_to welcome_about_path, :notice => "Your about family was succesfully updated."
    else
      redirect_to post_path(@post), alert: @post.errors
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @content = current_user.contents.build(content_params.merge(folder_id: Folder.find_by(title: :Post)))
    if @post.save
      redirect_to posts_path, :notice => "Your post was succesfully created."
    else
      redirect_to new_post_path, alert: "Error in #{@post.errors.first[0]}: #{@post.errors.first[1]}"
    end
  end

  def destroy
    if current_user == Post.find(params[:id]).user
      @post = Post.find(params[:id])
      @post.destroy
      FileUtils.rm_rf("public/uploads/post/image/#{params[:id]}")
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
end
