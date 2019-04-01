require_relative "unavailable"

module Hotel
  class Reservation < Unavailable
    attr_reader :cost

    def initialize(check_in:, check_out:, room_price: 200, percent_discount: 0)
      super(check_in: check_in, check_out: check_out)
      calc_price(price: room_price, percent_discount: percent_discount)
    end

    def calc_price(price:, percent_discount:)
      @cost = price * duration_in_days * (100 - percent_discount) / 100.0
    end

    private

    # Override
    def generate_confirmation_id(prefix: "R")
      return prefix + self.class.confirmation_number_generator.to_s
    end
  end
end
