require 'date'
# require_relative 'hotel.rb'

module Booking
  class Room
    ROOM_COST = 200
    MAX_ROOM = 20
    attr_reader :number, :checkin_date, :checkout_date, :total_cost, :cost, :status
    attr_accessor :reservations

    def initialize(number, checkin_date: nil, checkout_date: nil, cost: 200)
      @total_statuses = [:AVAILABLE, :BOOKED]
      @number = number
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @total_cost = self.total_cost
      @reservations = reservations || []
    end
  end
end
