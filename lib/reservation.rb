require "date"

module Hotel
  class Reservation
    attr_reader :room, :start_date, :end_date

    def initialize(room:, start_date:, end_date:)
      @room = room

      @start_date, @end_date = parse_dates(start_date, end_date)
    end

    def calculate_cost
      total_cost = ((@end_date - @start_date) - 1) * @room.cost_per_night
      return total_cost
    end

    def overlap?(start_date, end_date)
      return self.start_date >= start_date && self.end_date <= end_date
    end

    def includes?(date)
      return date >= self.start_date && date < self.end_date
    end

    private

    def parse_dates(start_date, end_date)
      start_date = Date.parse(start_date) if start_date.is_a? String
      end_date = Date.parse(end_date) if end_date.is_a? String
      validate_dates(start_date, end_date)
      return start_date, end_date
    end

    def validate_dates(start_date, end_date)
      unless end_date > start_date
        raise ArgumentError, "End date must be after start date"
      end
    end
  end
end
