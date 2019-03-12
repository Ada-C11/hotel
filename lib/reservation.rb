# require "date"

module Hotel
  class Reservation
    PRICE = 200

    attr_reader :first_night, :last_night, :length_of_stay, :cost, :room, :dates

    def initialize(start_date:, end_date:, room:)
      @first_night = start_date
      @last_night = end_date - 1
      @length_of_stay = end_date - start_date

      dates = []
      night = start_date
      until night == end_date # (not including end date)
        dates << night
        night += 1
      end

      @dates = dates

      @cost = @length_of_stay * PRICE

      @room = room
    end
  end
end
