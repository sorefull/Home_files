class AdminsController < ApplicationController
  before_action :admin?

  def index
    @users = User.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 3)
  end

  def change
    @user = User.find(params[:id])
    unless current_user == @user
      @user.admin? ? @user.user! : @user.admin!
      redirect_to admins_show_path(@user), :notice => "Role was changed to #{@user.role}"
    else
      redirect_to admins_show_path(@user), :alert => "You can't change your role!"
    end
  end


    def set_to_about_welcome
      old_post = Post.find_by(about_welcome: true)
      if old_post
        old_post.about_welcome = false
        old_post.save
      end
      @post = Post.friendly.find(params[:id])
      @post.about_welcome = true
      if @post.save
        redirect_to welcome_about_path, :notice => "Your about family was succesfully updated."
      else
        redirect_to post_path(@post), alert: @post.errors
      end
    end

    def delete_adout
      old_post = Post.find_by(about_welcome: true)
      if old_post
        old_post.about_welcome = false
        old_post.save
      end
      redirect_to root_path, :notice => "About info succesfully deleted."
    end

  private
  def admin?
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404 unless current_user&.admin?
  end
end
