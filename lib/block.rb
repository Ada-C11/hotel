require_relative "reservation"

module Hotel
  class Block
    attr_reader :rooms, :start_date, :end_date, :discount_rate

    def initialize(rooms:, start_date:, end_date:, discount_rate:)
      @start_date = start_date
      @end_date = end_date
      validate_rooms(rooms)
      @rooms = rooms
      @discount_rate = discount_rate
    end

    private

    def validate_rooms(rooms)
      unless rooms.length <= 5
        raise ArgumentError, "The max number of rooms for a block is 5."
      end
    end
  end
end
