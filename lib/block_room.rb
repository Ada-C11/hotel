require "date"
require "time"

module Hotel
  class BlockRoom
    attr_reader :room_booking_ref
    attr_accessor :room_booking_ref, :block_room_number, :check_in, :check_out

    def initialize(room_booking_ref:, block_room_number:, check_in:, check_out:)
      @room_booking_ref = room_booking_ref
      @block_room_number = block_room_number
      @check_in = check_in
      @check_out = check_out
    end # initialize
  end # class
end # module
