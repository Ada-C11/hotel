require_relative "unavailable"

module Hotel
  class Reservation < Unavailable
    attr_accessor :cost

    def initialize(check_in:, check_out:)
      super(check_in: check_in, check_out: check_out)
    end

    private

    # Override
    def generate_confirmation_id(prefix: "R")
      return prefix + self.class.confirmation_number_generator.to_s
    end
  end
end
