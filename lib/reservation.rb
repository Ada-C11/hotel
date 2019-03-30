require "date"

module Hotel
  class Reservation
    attr_reader :checkin, :checkout, :nights, :dates, :room
    def initialize(checkin:, checkout:, room: nil)
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      @nights = Hotel::Reservation.num_nights(checkin, checkout)
      @dates = Hotel::Reservation.reservation_dates(checkin, checkout)
      @room = room
    end

    def self.reservation_dates(checkin, checkout)
      checkin = Date.parse(checkin)
      checkout = Date.parse(checkout)
      return (checkin.to_s..(checkout-1).to_s).to_a
    end

    def self.num_nights(checkin, checkout)
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