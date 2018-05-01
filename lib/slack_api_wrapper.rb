require 'httparty'
require "pry"

class SlackApiWrapper
  # Your code here!
  def self.list_channels
    token = ENV["SLACK_TOKEN"]
    url  = "https://slack.com/api/channels.list?token=#{token}"
    response = HTTParty.get(url)

    unless response["ok"]
      raise StandarError.new(response["error"])
    end

    return response["channels"].map do |raw_channel|
      Channel.from_api(raw_channel)
      #created a from_api to channel in lib to be able to dry up the code a little bit and we isolate the [:name] in channels over there.
    end

  end

  def self.send_message(channel_name, message)
    token = ENV["SLACK_TOKEN"]
    url_root = "https://slack.com/api/chat.postMessage"
    full_url = URI.encode("#{url_root}?channel=#{channel_name}&text=#{message}&token=#{token}")
    #the name of the list is url_root and is always that with a ? after, then are all the key value pairs with an & in between. the order does not matter. To test it we put a puts

    puts "About to send request to #{full_url}"

    response = HTTParty.post(full_url)

    unless response["ok"]
      raise StandarError.new(response["error"])

    end
  end

end
