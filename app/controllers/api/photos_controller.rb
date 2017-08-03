module Api
  class PhotosController < Api::ApplicationController
    before_action :set_user
    before_action :set_photo, only: [:show, :edit, :update, :destroy]

    def index
      @photos = @user.photos.order(id: :desc).all
      render json: @photos
    end

    def show
      render json: @photo
    end

    def create
      @photo = @user.photos.new(photo_params)
      if @photo.save
        IndexFacesJob.perform_later(@photo)
        render json: @photo
      else
        render json: @photo.errors, status: :unprocessable_entity
      end
    end

    def update
      if @photo.update(photo_params)
        IndexFacesJob.perform_later(@photo)
        render json: @photo
      else
        render json: @photo.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @photo.destroy
      head :no_content
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
end
