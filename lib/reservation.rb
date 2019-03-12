require "date"

module Hotel
  class Reservation
    attr_reader :checkin, :checkout, :dates
    def initialize(checkin, checkout)
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      @dates = self.reservation_dates
      @room = nil
    end

    def reservation_dates
      (checkin.to_s..(checkout-1).to_s).to_a
    end
  end
end
