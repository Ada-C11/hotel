module Hotel
  class Block
    def initialize(date_range, rooms, discounted_rate)
      @date_range = date_range
      @rooms = rooms
      @discounted_rate = discounted_rate
    end
  end
end