class FoldersController < ApplicationController
  before_action :authenticate_user!, except: :public
  before_action :owner?, only: :set_folder
  before_action :set_folder, only: [:show, :destroy]

  def index
    @folders = current_user.folders.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 12)
  end

  def new
    @folder = current_user.folders.new
  end

  def create
    @folder = current_user.folders.build(folder_params)
    if @folder.save
      redirect_to folders_path, :notice => "Your folder was succesfully created."
    else
      redirect_to new_folder_path, alert: "Error in #{@folder.errors}"
    end
  end

  def show
    @contents = @folder.contents.paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    @folder.contents.each do |content|
      FileUtils.rm_rf("public/uploads/content/content/#{content.id}")
    end
    @folder.destroy
    redirect_to folders_path, alert: "Your folder was succesfully deleted!"
  end

  def about
  end

  def about_public
  end

  def public
    @contents = Content.where(public: true).order('created_at DESC').paginate(:page => params[:page], :per_page => 12)
  end

  private
  def folder_params
    params.require(:folder).permit(:title)
  end

  def owner?
    unless current_user == Folder.friendly.find(params[:id]).user
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def set_folder
    @folder = current_user.folders.friendly.find(params[:id])
  end
end
