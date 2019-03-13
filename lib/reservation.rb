require "date"

module HotelSystem
  class Reservation
    attr_reader :room, :start_date, :end_date, :price, :guest, :reservation_id

    def initialize(room:, start_date:, end_date:, guest:)
      @start_date = start_date
      @end_date = end_date
      @room = room
      @price = 200
      @guest = guest
      @reservation_id = ((0...5).map { rand(10) }).join.to_s
      raise ArgumentError, "Invalid date range" if @end_date <= @start_date
    end

    def calculate_cost
      return ('%.2f' % ((@end_date - @start_date) * @price)).to_f
    end
  end
end
