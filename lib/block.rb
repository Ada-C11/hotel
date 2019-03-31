require_relative "booking.rb"

module Hotel
  class Block
    def initialize(checkin, checkout, rooms, discounted_rate)
      @checkin = Date.parse(checkin)
      @checkout = Date.parse(checkout)
      @rooms = rooms
      @discounted_rate = discounted_rate
    end
  end
end
