module Hotel
  class Room
    attr_reader :number
    attr_accessor :availability #, :status

    def initialize(number)
      @number = number
      @availability = []
      #@status = []
    end

    def add_reservation(reservation)
      booked = reservation.reserved_nights
      @availability << booked
    end
  end
end
