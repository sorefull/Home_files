class AdminsController < ApplicationController
  before_action :admin?

  def index
    @users = User.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = User.find_by(username: params[:username])
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 3)
  end

  def change
    @user = User.find_by(username: params[:username])
    unless current_user == @user
      @user.admin? ? @user.user! : @user.admin!
      redirect_to admins_show_path(@user.username), :notice => "Role was changed to #{@user.role}"
    else
      redirect_to admins_show_path(@user.username), :alert => "You can't change your role!"
    end
  end

  def set_to_about_welcome
    old_post = Post.find_by(about_welcome: true)
    if old_post
      old_post.about_welcome = false
      old_post.save
    end
    @post = Post.find_by(title: params[:title])
    @post.about_welcome = true
    if @post.save
      redirect_to welcome_about_path, :notice => "Your about family was succesfully updated."
    else
      redirect_to post_show_path(@post.title), alert: @post.errors
    end
  end

  def delete_about
    old_post = Post.find_by(about_welcome: true)
    if old_post
      old_post.about_welcome = false
      old_post.save
      redirect_to welcome_about_path, notice: 'Info was succesfully deleted.'
    else
      redirect_to welcome_about_path, alert: 'Nothing to delete.'
    end
  end

  private
  def admin?
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404 unless current_user.admin?
  end
end
