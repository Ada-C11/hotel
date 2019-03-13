require_relative "unavailable"

module Hotel
  class Reservation < Unavailable
    def initialize(check_in:, check_out:)
      super(check_in: check_in, check_out: check_out)
    end
  end
end
