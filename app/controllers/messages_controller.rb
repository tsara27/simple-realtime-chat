class MessagesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @users = user_signed_in? ? User.where.not(id: current_user.id) : User.all
  end
end
