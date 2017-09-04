class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  def index
    @sessions = Session.page params[:page]
  end

  def show
  end

  def new
    @session = Session.new
  end

  def edit
  end

  def create
    @session = Session.new(session_params)
    if @session.save
      redirect_to @session, notice: 'Session was successfully created.'
    else
      render :new
    end
  end

  def update
    if @session.update(session_params)
      redirect_to @session, notice: 'Session was successfully updated.'
    else
      render :edit
    end
  end
end

def destroy
  @session.destroy
  redirect_to sessions_url, notice: 'Session was successfully destroyed.'
end

private
def set_session
  @session = Session.find(params[:id])
end

def session_params
  params.require(:session).permit(:time, :place, :title, :detail, :number)
end