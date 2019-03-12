class Booking

  attr_reader :room_number, :cost, :availability, :date
  attr_accessor :name

  def initialize(name)
    @room_number = room_number
    @cost = cost
    @availability = availability
    @date = date
  end
end

