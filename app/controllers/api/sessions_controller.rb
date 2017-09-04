module Api
  class SessionsController < Api::ApplicationController

    def index
      @sessions = Session.all.order(:number)
      render json: @sessions
    end
  end
end
