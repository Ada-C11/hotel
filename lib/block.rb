module HotelSystem
  class Block
    def initialize(rooms:, date_range:, discount_rate:)
      @rooms = rooms
      @date_range = date_range
      @discount_rate = discount_rate
    end
  end
end
