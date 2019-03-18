# Require gems
require "date"

# Require relatives
require_relative "room.rb"
require_relative "reservation.rb"

module Hotel
  class Block
    attr_reader :rooms, :discounted_rate, :check_in, :check_out

    def initialize(rooms:, discounted_rate:, check_in:, check_out:)
      @rooms = rooms
      @discounted_rate = discounted_rate
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
    end
  end
end
