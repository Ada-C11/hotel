require "date"
require_relative "room"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date
    attr_accessor :date_range

    def initialize(id:, room:, start_date: nil, end_date: nil, date_range: nil)
      @id = id
      @room = room

      if date_range
        @date_range = date_range
      else
        unless start_date && end_date
          raise ArgumentError, "one of start + end date or date range is required"
        end
        # Constructor for DateRange checks range validity
        @date_range = DateRange.new(start_date, end_date)
      end
    end

    def total_cost
      return ("%.2f" % (200.00 * duration)).to_f
    end

    def duration
      return (date_range.end_date - date_range.start_date).to_i
    end
  end # class Reservation
end # module Hotel
