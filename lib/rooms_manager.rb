# Hotel Rooms class file
require 'pry'

module Hotel
  class Room
    # rooms know their number and cost, trying to keep it simple
    attr_reader :room_number, :price_per_night
    def initialize(room_number, price_per_night)
      @room_number = room_number
      @price_per_night = price_per_night
    end
  end
end
