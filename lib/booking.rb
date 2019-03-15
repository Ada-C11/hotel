module HotelBooking
  class Booking
    
  attr_reader :reference_number, :room, :start_date, :end_date, :price

    def initialize(reference_number:, room:, start_date:, end_date:, price: 200)
      @reference_number = reference_number
      @room = room
      @start_date = start_date.to_s
      @end_date = end_date.to_s
      @price = price
    end

    def overlaps?(start_date, end_date)
      start_date_obj = Date.parse(start_date)
      end_date_obj = Date.parse(end_date)
      Date.parse(@start_date) <= start_date_obj && Date.parse(@end_date) >= end_date_obj
    end

    def booking_duration
      duration = Date.parse(@end_date) - Date.parse(@start_date)
      duration.to_i
    end

    def booking_cost
      self.booking_duration * price
    end
  end
end
