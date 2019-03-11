require "date"
require_relative "front_desk"

module Hotel
  class Reservation
    @@list = []
    PRICE = 200

    attr_reader :first_night, :last_night, :length_of_stay, :cost, :room

    def initialize(start_date, end_date)
      @first_night = start_date
      @last_night = end_date - 1
      @length_of_stay = end_date - start_date
      @cost = @length_of_stay * PRICE

      if defined?(hotel)
        find_room
      else
        def hotel
          @hotel = FrontDesk.new
        end

        find_room
      end
    end

    def find_room
      hotel.rooms.each do |room|
        if room.available?
          @room = room
          break
        else
          raise ArgumentError, "No rooms available"
        end
      end
    end
  end
end
