
module Hotel
  class Reservation
    attr_reader :id, :start_date, :end_date, :room_number

    def initialize(id, start_date, end_date, room_number)
      @id = id
      validate_date_range(start_date, end_date)
      @room_number = room_number
      @total_nights = total_nights
      @total_cost = total_cost
    end

    def validate_date_range(start_date, end_date)
      if start_date > end_date
        raise ArgumentError, "Invalid date range"
      else
        @start_date = start_date
        @end_date = end_date
      end
    end

    def total_nights
      total_nights = (end_date - start_date) / 86400
      return total_nights.to_i
    end

    def total_cost
      cost_per_night = 200.0
      total_cost = 0
      total_cost = total_nights * cost_per_night
      return total_cost
    end
  end
end
