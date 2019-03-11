
module Hotel
  class FrontDesk
    NUMBER_OF_ROOMS = 20

    attr_reader :rooms_array, :reservations

    def initialize
      @reservations = []
    end

    def rooms
      rooms_array = []
      NUMBER_OF_ROOMS.times do |i|
        rooms_array << Room.new(i + 1)
      end
      return rooms_array
    end

    def reserve(start_date, end_date)
      new_reservation = Reservation.new(start_date, end_date)
      @reservations << new_reservation
      return new_reservation
    end
  end
end
