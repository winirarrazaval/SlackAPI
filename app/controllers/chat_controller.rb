class ChatController < ApplicationController
  def index
    @channels = SlackApiWrapper.list_channels
  end

  def new
    @channel_name = params[:channel]
  end

  def create
    message = params[:message]
    channel_name = params[:channel]

    SlackApiWrapper.send_message(channel_name, message)

    flash[:status] = :success
    flash[:message] = "Successfully sent message"

    redirect_to root_path

  end
end
