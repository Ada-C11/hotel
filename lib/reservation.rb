module Hotel
  class Reservation
    attr_reader :room, :start_date, :end_date

    def initialize(room:, start_date:, end_date:)
      @room = room

      self.class.validate_dates(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end

    def calculate_cost
      total_cost = ((@end_date - @start_date) - 1) * @room.cost_per_night
      return total_cost
    end

    def self.validate_dates(start_date, end_date)
      unless end_date > start_date
        raise ArgumentError, "End date must be after start date"
      end
    end
  end
end
