module Hotel
  class ReservationManager
    attr_reader :reservations

    def initialize
      @reservations = []
    end

    def rooms
      @rooms = (1..20).to_a
      return @rooms
    end

    def create_reservation(start_date, end_date) # should I parse the dates here??? not when I'm creating the reservation in the specs??
      id = @reservations.length + 1
      room = rooms.sample
      new_reservation = Reservation.new(id, start_date, end_date, room)
      @reservations << new_reservation
      return new_reservation
    end

    # def find_reservation(id:, start_date: nil, end_date: nil)
    #   found = ""
    #   criteria = [id, start_date, end_date]

    #   if criteria.include?(id)
    #     hey = reservations
    #     found = hey.find(id)
    #     return found
    #   end
    #   # when start_date.class == Time && end_date.class
    #   # when start_date || end_date
    #   # end

    #   # @reservations.include?(id)
    # end
  end
end

#5:11 last changed not commited yet!!
