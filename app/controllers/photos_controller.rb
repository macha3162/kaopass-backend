class PhotosController < ApplicationController
  before_action :set_user
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = @user.photos.order(id: :desc).all
  end

  def show
  end

  def new
    @photo = @user.photos.new
  end

  def edit
  end

  def create
    @photo = @user.photos.new(photo_params)
    if @photo.save
      IndexFacesJob.perform_later(@photo)
      redirect_to [@user, @photo], notice: 'Photo was successfully created.'
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      IndexFacesJob.perform_later(@photo)
      redirect_to [@user, @photo], notice: 'Photo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to user_photos_path(@user), notice: 'Photo was successfully destroyed.'
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_photo
    @photo = @user.photos.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:image)
  end
end
