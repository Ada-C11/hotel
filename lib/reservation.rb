
module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room, :block_id, :discount
    attr_accessor :reservation_id, :status
    # add discount to initialize as an optional
    def initialize(start_date, end_date, room, status: nil, reservation_id: nil, block_id: nil, discount: nil)
      @start_date = start_date
      @end_date = end_date
      @room = room
      @total_nights = total_nights
      @total_cost = total_cost
      @status = status
      @reservation_id = reservation_id
      @block_id = block_id
      @discount = discount
    end

    def total_nights
      total_nights = (end_date - start_date) / 86400
      return total_nights.to_i
    end

    def total_cost
      cost_per_night = 200.0
      total_cost = 0
      if discount.class == Float
        discounted_cost_per_night = cost_per_night * (1 - discount)
        total_cost = discounted_cost_per_night * total_nights
        return total_cost
      end
      total_cost = total_nights * cost_per_night
      return total_cost
    end
  end
end
