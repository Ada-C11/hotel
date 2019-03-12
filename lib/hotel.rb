require_relative "room"
require_relative "reservation"

module HotelSystem
  class Hotel
    attr_reader :all_rooms
    attr_accessor :all_reservations

    def initialize
      @all_reservations = []
      @all_rooms = []
      generate_rooms(20)
    end

    def generate_rooms(number_of_rooms)
      number_of_rooms.times do |i|
        @all_rooms << Room.new(i + 1)
      end
    end

    def make_reservation
    end
  end
end
