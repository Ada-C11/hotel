require "time"

module Hotel
  class Frontdesk
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = Hotel::Room.all_rooms
      @reservations = []
    end

    # make a request reservation method

  end
end
