require 'date'

module Booking
  class Room
    ROOM_COST = 200
    attr_reader :number, :checkin_date, :checkout_date, :total_cost, :status

    def initialize(number, checkin_date, checkout_date, status: :AVAILABLE)
      @avail_statuses = [:AVAILABLE, :BOOKED]
      @number = number
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @total_cost = self.total_cost
    end

    def total_cost
      days_spent = (self.checkout_date - self.checkin_date)
      total = (days_spent)*ROOM_COST
      return total
    end
  end
end
