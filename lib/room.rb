module Hotel
  class Room
    attr_reader :number, :cost

    def initialize(number, cost)
      @number = number
      @cost = cost
      @reservations = []
    end


    def list_of_reservations

    end

    def add_reservation(reservation)
      @reservations << reservation
    end
  


    def available_on_this_date?(date)

    end

  end
    
end
   