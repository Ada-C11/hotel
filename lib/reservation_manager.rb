module Hotel
  class ReservationManager
    def initialize
      @reservations = []
    end

    def reservations
      reservations << reservation # Where does reservation come from
    end

    def rooms
      rooms = [1..20]
      return rooms
    end

    def self.create_reservation(start_date, end_date)
      return rooms.sample #Method
    end
    
  end
end
