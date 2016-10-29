class PusherController < ApplicationController
  def auth
    if user_signed_in?
      response = Pusher.authenticate(params[:channel_name], params[:socket_id])
      render json: response
    else
      render text: 'Forbidden', status: '403'
    end
  end
end
