
module HotelSystem
  class Room
    attr_reader :id, :reservations, :price_per_night

    def initialize(id:, price_per_night: 200, reservations: [])
      @id = id
      @price_per_night = price_per_night
      @reservations = reservations
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    ##### NEEDS TESTS
    def available?(date)
      # puts " IN RES #{date.class.object_id}"
      reservations.each do |reservation|
        reservation.date_range.each do |reserved_date|
          return false if reserved_date.to_s == date.to_s
        end
      end
      return true
    end
  end
end
