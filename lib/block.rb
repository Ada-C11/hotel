module Hotel
  class Block
    attr_reader :rooms, :start_date, :end_date, :discount_rate

    def initialize(rooms:, start_date:, end_date:, discount_rate:)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      self.class.validate_rooms(rooms)
      @rooms = rooms
      @discount_rate = discount_rate
    end

    def self.validate_rooms(rooms)
      unless rooms.length <= 5
        raise ArgumentError, "The max number of rooms for a block is 5."
      end
    end
  end
end
