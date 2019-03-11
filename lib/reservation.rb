module Hotel
  class Reservation
    def initialize(room, start_date, end_date)
      @room = room
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end

    def calculate_cost
      total_cost = ((@end_date - @start_date) - 1) * @room.cost_per_night
      return total_cost
    end
  end
end
