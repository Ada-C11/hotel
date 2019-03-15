
class Room
  attr_accessor :status
  attr_reader :id, :reservation, :rooms, :dates

  def initialize(id:)
    @id = id
    @dates = []
  end

  def add_bookings(booking)
    @bookings << booking
  end
end
