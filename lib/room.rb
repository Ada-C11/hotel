class Room
  attr_reader :id

  def initialize(id)
    if !(1..20).include?(id)
      raise ArgumentError.new("Room IDs must be between 1 and 20")
    end
  end
end