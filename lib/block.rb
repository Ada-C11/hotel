require_relative "booking.rb"

module Hotel
  class Block
    def initialize(date_range, rooms, discounted_rate, booking)
      @rooms = rooms
      @date_range = date_range
      check_rooms(date_range, booking)
      @discounted_rate = discounted_rate
    end

    def check_rooms(date_range, booking)
      @rooms.each do |room|
        room.reservations.each do |res|
          booking.check_availability(@date_range)
        end
      end
    end

  end
end