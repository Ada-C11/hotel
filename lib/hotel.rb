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

    def make_reservation(room:, start_date:, end_date:, guest:)
      #throw an exception if the room isnt available
      #call date_available? on the given room. if its not available then have a rescue block begin
    end

    def room_available?(new_start_date, new_end_date)
      @all_rooms.each do |room|
        if room.date_available?(new_start_date, new_end_date)
          return true
        else
          next
        end
      end
      return false
    end

    def add_reservation
    end
  end
end
