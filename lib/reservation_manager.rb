class ReservationManager
  attr_reader :rooms

  def initialize
    @rooms = (1..20).map { |num| Room.new(number: num) }
  end
end
