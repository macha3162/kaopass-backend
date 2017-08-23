module Api
  class SessionHistoriesController < Api::ApplicationController
    before_action :set_user

    def create
      numbers = (params[:session_numbers]||[]).map{|n|n.strip.to_i}
      @user.session_histories.destroy_all
      sessions = Session.where(number: numbers) || []
      sessions.each do |session|
        @user.session_histories.create(session: session)
      end
      ActionCable.server.broadcast 'user_channel', message: 'reload'
      head :created
    end

    private
    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
