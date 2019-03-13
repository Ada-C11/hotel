require "date"

require_relative "reservation"
require_relative "room"

module Hotel
  class Manager
    attr_reader :reservation, :room

    def initialize
      @reservation = reservation
      @room = room
    end

    # has a find method for each class
    # has a list of rooms (20 rooms total)
    # total cost for given reservation
    # raises exceptions for invalid date ranges

  end
end
