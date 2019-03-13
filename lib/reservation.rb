# require "date"

module Hotel
  class Reservation
    attr_reader :first_night, :last_night, :length_of_stay, :cost, :room, :dates

    def initialize(room:, dates:)
      @length_of_stay = dates.length

      @dates = dates

      @room = room

      @cost = length_of_stay * room.rate
    end
  end
end
