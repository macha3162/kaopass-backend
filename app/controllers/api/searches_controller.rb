module Api
  class SearchesController < Api::ApplicationController
    before_action :set_search, only: [:show, :edit, :update, :destroy]

    def index
      @searches = Search.order(id: :desc).page params[:page]
      render json: @searches
    end

    def show
      begin
        face_matchs = Face.find_by_s3(@search.image.path).face_matches
        face_match = face_matchs.first
        if face_match.present?
          photo = Photo.find_by(id: face_match.face.external_image_id)
          render json: photo.user if photo.present?
        end
      rescue
        head :bad_request
      end
    end

    def create
      @search = Search.new(search_params)
      face_matchs = Face.find_by_image(@search.image).face_matches
      face_match = face_matchs.first
      if face_match.present?
        photo = Photo.find_by(id: face_match.face.external_image_id)
        if photo.present?
          photo.user.visit_histories.create
          render json: photo.user
        end
      end
    rescue
      head :bad_request
    end

    # 検索クエリの保存どうする？？
    # def create
    #   @search = Search.new(search_params)
    #   if @search.save
    #     show
    #   else
    #     render json: @search.errors, status: :unprocessable_entity
    #   end
    # end

    def update
      if @search.update(search_params)
        show
      else
        render json: @search.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @search.destroy
      head :no_content
    end

    private
    def set_search
      @search = Search.find(params[:id])
    end

    def search_params
      params.require(:search).permit(:image)
    end
  end
end
