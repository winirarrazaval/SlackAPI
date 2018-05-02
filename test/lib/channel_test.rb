require "test_helper"

describe Channel do
  describe "initialize" do
    it "can be created with name and ID" do
      id = 12345
      name = "test channel"

      channel = Channel.new(name, id)

      channel.name.must_equal name
      channel.id.must_equal id
    end


    it "cannot be created without a name or an id" do
      proc { Channel.new()}.must_raise ArgumentError
      proc { Channel.new(name)}.must_raise ArgumentError
      proc { Channel.new("",12345)}.must_raise ArgumentError
      proc { Channel.new(nil, 12345)}.must_raise ArgumentError
    end

  end

  describe "from_api" do
    before do
      @fake_channel_data = {
        "name" => "test channel",
        "id" => 12345
      }
    end

    it "pulls the relevant information into an instance of channel" do
      channel = Channel.from_api(@fake_channel_data)

      channel.must_be_kind_of Channel
      channel.name.must_equal @fake_channel_data["name"]
      channel.id.must_equal @fake_channel_data["id"]
    end

    it "raises and exception without critical data" do
      @fake_channel_data["name"] = nil
      proc { Channel.from_api(@fake_channel_data)}.must_raise
    end


  end
end
