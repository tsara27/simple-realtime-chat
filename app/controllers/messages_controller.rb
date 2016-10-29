class MessagesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @users = user_signed_in? ? User.where.not(id: current_user.id) : User.all
  end

  def show
    @messages = Message.where('(sender_id = :current_user AND recipient_id = :opposite_user) OR (sender_id = :opposite_user AND recipient_id = :current_user)', current_user: current_user.id, opposite_user: params[:recipient]).order('created_at ASC')
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    trigger_message! if @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content, :recipient_id)
                            .merge(sender_id: current_user.id)
  end

  def trigger_message!
    Pusher.trigger(params[:channel], 'message', {
      sender: @message.sender.name,
      sender_id: @message.sender_id,
      content: @message.content,
      timestamp: @message.created_at.to_formatted_s(:short)
    })
  end
end
