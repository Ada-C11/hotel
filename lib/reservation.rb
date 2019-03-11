# Require gems

# Require relatives
require_relative "room.rb"

module Hotel
  class Reservation
    attr_reader

    def initialize(check_in:, check_out:, room_number:, total_cost: nil, id: nil)
      @check_in = check_in
      @check_out = check_out
      @room_number = room_number
      @total_cost = total_cost
      @id = id
    end
  end
end
