require "pry"
require "date"

module Hotel
  class Reservation
    attr_reader :reservation_id, :room_id, :check_in_date, :check_out_date

    def initialize(reservation_id:,
                   room_id:,
                   check_in_date:,
                   check_out_date:,
                   rate: 200)
      @reservation_id = reservation_id
      @room_id = room_id
      @check_in_date = Date.parse(check_in_date)
      @check_out_date = Date.parse(check_out_date)
      @rate = rate
    end

    def total_cost
      return (@check_out_date - @check_in_date) * @rate
    end
  end
end
