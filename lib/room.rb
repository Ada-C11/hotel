module Hotel
  class Room
    attr_reader :number, :rate, :reservations

    def initialize(number:, rate: 200, reservations: [])
      @number = number
      @rate = rate
      @reservations = reservations
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    # def add_reservation(reservation)
    #   @reservations << reservation
    # end
  end
end
