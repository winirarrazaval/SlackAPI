class Channel
  attr_reader :name, :id, :purpose, :is_archived, :members

  def initialize(name, id, options = {})

    raise ArgumentError if name == nil || name == "" || id == nil || id == ""

    @name = name
    @id = id
    @purpose = options[:purpose]
    @members = options[:members]
    @is_archived = options[:is_archived]
  end
end
