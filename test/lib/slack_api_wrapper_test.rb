require "test_helper"

describe "SlackApiWrapper" do
  describe "list_channels" do

    it "gives a list of channels" do
      VCR.use_cassette("channels") do
        channels = SlackApiWrapper.list_channels

        channels.each do |channel|
          channel.must_be_kind_of Channel

          # remember to gem "dotenv-rails" move it in the gem file to the development and test , not just developmet because it is going to fail.
        end
      end
    end

    it "throughs and error if the auth is bad" do
      skip "beyond our scope"
    end

  end
  describe "send_message" do
    it "sends a message to a real channel" do
      VCR.use_cassette("channel") do
        message = "test message"
        channel = "test-api-channel"

        SlackApiWrapper.send_message(channel, message)
        #our method does not do anything, success is when it does not raise an error. It is just a command.
      end
    end

    it "raises an error when  sending a message to a channel that does not exist" do
      VCR.use_cassette("channel") do
        message = "test message"
        channel = "this-channel-does-not-exist"

        proc {SlackApiWrapper.send_message(channel, message)}.must_raise SlackApiWrapper::SlackError
      end
    end

    it  "does something with an empty message" do
    end

    it "does something with an empty channel" do
    end


  end
end
