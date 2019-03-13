require_relative "../spec/spec_helper"
require_relative "unavailable"

module Hotel
  class Reservation < Unavailable
    def initialize(check_in:, check_out:)
      super()
    end
  end
end
