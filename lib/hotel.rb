require_relative "room"

module HotelSystem

  class Hotel
    attr_reader :rooms, :reservations
    
    def initialize
      @rooms = []
      (1..20).each do |num|
        room = HotelSystem::Room.new(num)
        @rooms << room
      end
      @reservations = []
    end
    
  end
end
