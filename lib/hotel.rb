class Hotel
  attr_reader :name, :rooms

  def initialize
    @name = name
    #@reservations = []
    @rooms = []
    id = 1
    20.times do
      room = Room.new(id)
      @rooms << room
      id += 1
    end
  end

  def self.load_rooms
    return @rooms
  end
end
