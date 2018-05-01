class ChatController < ApplicationController
  def index
    @channels = SlackApiWrapper.list_channels

  end

  def new
    @channel = params["channel"]
  end

  def create
    @channel = params["channel"]
    SlackApiWrapper.send_msg(@channel, params["message"])

    redirect_to chat_new_path(@channel)
  end
end
