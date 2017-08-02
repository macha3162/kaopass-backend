class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def index
    @searches = Search.order(id: :desc).page params[:page]
  end

  def show
    @face_matchs = Face.find_by_s3(@search.image.path).face_matches
    pp @face_matchs
  end

  def new
    @search = Search.new
  end

  def edit
  end

  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_search
      @search = Search.find(params[:id])
    end

    def search_params
      params.require(:search).permit(:image)
    end
end
