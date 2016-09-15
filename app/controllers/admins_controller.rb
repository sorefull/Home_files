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

  private
  def admin?
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404 unless current_user.admin?
  end
end
