require_relative 'room'
require_relative 'date_range'

class BookingCentral 
  attr_accessor :rooms, :all_reservations
  
  def initialize
    @rooms = []

    (1..20).each do |number|
      room = Room.new(number, room_reservations: [])
      @rooms << room
    end
  end

  # def self.reserve_room(date_range)

    
  # end

end


