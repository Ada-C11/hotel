module Hotel
  class Room
    attr_reader :number
    attr_accessor :availability #, :status

    def initialize(number)
      @number = number
      @availability = []
    end

    def add_reservation(reservation)
      booking = reservation.reserved_nights
      booking.each do |night|
        @availability << night
      end
    end
  end
end
