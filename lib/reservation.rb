module HotelSystem
  class Reservation
    attr_reader :date_range, :room, :id, :name, :block

    def initialize(date_range:, room:, id:, name:, block: nil)
      @id = id
      @room = room
      @date_range = date_range
      @name = name
      @block = block
    end

    # Calculation methods

    def total_cost
      return rate * number_of_nights
    end

    def rate
      return block ? block.discount_rate : room.rate
    end

    def number_of_nights
      return date_range.length
    end

    # Date interaction methods

    def includes_date?(date)
      return date_range.includes_date?(date)
    end

    def overlap?(new_date_range)
      return date_range.overlap?(new_date_range)
    end
  end
end
