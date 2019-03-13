require_relative "room"
require_relative "reservation"
require_relative "reservation_block"

module Hotel
  class Hotel_ledger
    attr_reader :all_rooms

    def initialize
      @all_rooms = 1..20
      # @all_rooms.map! do |number|
      #   Room.new(number)
      # end
    end

    def list_all_rooms
      return @all_rooms
    end

    #   @reservations = Reservation.list_all(date)
    #   @reservation_blocks = Reservation_block.list_all(date)
    # end

    # def available?(range_of_date)
    #   date = Date.parse(range_of_date)
    #   return # room is available ? true : false
    # end
    #   end
  end
end

# list_all_rooms = Hotel::Hotel_ledger.new.list_all

# list_all_rooms.each do |room|
#   puts "#{room.room_number}"
# end
