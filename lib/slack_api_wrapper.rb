require 'httparty'

class SlackApiWrapper
  # Your code here!

  BASE_URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.list_channels
    url = BASE_URL + "channels.list?" + "token=#{TOKEN}" + "&exclude_archived=1"
    data = HTTParty.get(url)

    channel_list = []
    if data["channels"]
      data["channels"].each do |channel_data|
        channel_list << SlackApiWrapper.create_channel(channel_data)
      end
    end

    return channel_list
  end

  def self.send_msg(channel, msg)
    puts "Sending message to channel #{channel}: #{msg}"

    url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"
    response = HTTParty.post(url,
      body:  {
        "text" => "#{msg}",
        "channel" => "#{channel}",
        "username" => "CheezItBot",
        "icon_emoji" => ":cheezit:",
        "as_user" => "false"
      },
      :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
    return response.success?
  end

  private
    def self.create_channel(channel_data)
      return Channel.new(channel_data["name"], channel_data["id"], {
        purpose: channel_data["purpose"],
        is_archived: channel_data["is_archived"],
        members: channel_data["members"]
        })
    end
end
