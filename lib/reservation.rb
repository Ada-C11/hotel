require "date"

module Hotel
  class Reservation
    attr_reader :checkin, :checkout, :dates, :nights, :room
    def initialize(checkin:, checkout:, nights: nil, dates: nil, room: nil)
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      @nights = nights
      @dates = dates
      @room = room
    end

    def self.reservation_dates(checkin, checkout)
      checkin = Date.parse(checkin)
      checkout = Date.parse(checkout)
      return (checkin.to_s..(checkout-1).to_s).to_a
    end

    def self.nights(checkin, checkout)
      return (Hotel::Reservation.reservation_dates(checkin, checkout)).length
    end

    def self.validate_dates(checkin, checkout)
      checkin = Date.parse(checkin)
      checkout = Date.parse(checkout)
      today = Date.today
      if checkin < today
        raise ArgumentError, "Date cannot be in the past"
      end
      if checkout < today
        raise ArgumentError, "Date cannot be in the past"
      end
      if checkout < checkin
        raise ArgumentError, "Checkout cannot occur before checkin"
      end
    end

    def total_cost
      return @nights * room.cost
    end
  end
end