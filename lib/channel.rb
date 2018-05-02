class Channel
  #make the data that comes back from the API feel like a model, we are imitation the data the active record is sending, because an instance of a class is more managable for us.
attr_reader :name, :id

  def initialize(name, id)
    #this is a lazy validation:
    if name.nil? || name.empty?
      raise ArgumentError.new("Need a name please ")
    end
    @name = name
    @id = id
  end
  #this is a factory method, It resda the data we got back from the API, and turns it into an instance of channel by callinself.new

  def self.from_api(raw_channel)
    self.new(
      raw_channel["name"],
      raw_channel["id"]
    )
  end
end
