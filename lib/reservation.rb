require "time"
require "date"

module Hotel
  class Reservation
    # Getter
    attr_reader :room_number
    #Setter
    attr_accessor :booking_ref, :room_number, :start_date, :end_date, :total_cost
    # Constant
    COST_PER_NIGHT = 200.00

    # Constructor
    def initialize(booking_ref:, room_number:, start_date:, end_date:, total_cost:)

      # Instance variables visible to all methods within the Reservation class
      @booking_ref = booking_ref
      @room_number = room_number
      @start_date = start_date
      @end_date = end_date
      @total_cost = ((end_date - start_date) *
                     COST_PER_NIGHT)

      if (@start_date >= @end_date) || (@start_date < Date.today)
        raise ArgumentError, "end date cannot be before start date. Start date cannot be earlier than today's date."
      end
    end
  end # Class end
end # Module end
