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
    if @search.save
      redirect_to @search, notice: 'Search was successfully created.'
    else
      render :new
    end
  end

  def update
    if @search.update(search_params)
      redirect_to @search, notice: 'Search was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @search.destroy
    redirect_to searches_url, notice: 'Search was successfully destroyed.'
  end

  private
  def set_search
    @search = Search.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:image)
  end
end
