class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder

  def new
    @content = current_user.contents.new
  end

  def create
    if params[:content]
      @content = current_user.contents.build(content_params.merge(folder_id: @folder.id))
      if @content.save
        redirect_to folder_path(@folder), :notice => "Your file was succesfully added!"
      else
        redirect_to folder_path(@folder), alert: "Error in #{@content.errors}"
      end
    else
      redirect_to new_folder_content_path(@folder), alert: "File can't be blank"
    end
  end

  def destroy
    if current_user == @folder.user
      @content = @folder.contents.find(params[:id])
      @content.destroy
      FileUtils.rm_rf("public/uploads/content/content/#{params[:id]}")
      redirect_to folder_path(@folder), alert: "Your file was deleted!"
    else
      redirect_to root_path, alert: "Unable for you."
    end
  end

  def public!
    @content = @folder.contents.find(params[:id])
    @content.public = @content.public ? false : true
    redirect_to folder_path(@folder), :notice => "Your succesfully #{@content.public ? "published" : "hided"} your file!"
    @content.save
  end

  private
  def content_params
    params.require(:content).permit(:content)
  end

  def set_folder
    @folder = current_user.folders.friendly.find(params[:folder_id])
  end
end
