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

    respond_to do |format|
      if @photo.save
        IndexFacesJob.perform_later(@photo)
        format.html { redirect_to [@user, @photo], notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: [@user, @photo] }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        IndexFacesJob.perform_later(@photo)
        format.html { redirect_to [@user, @photo], notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: [@user, @photo] }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to user_photos_path(@user), notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
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
