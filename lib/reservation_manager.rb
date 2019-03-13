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

    def find_reservation(id: nil, date: nil)
      index = 0
      if id.class == Integer
        @reservations.find do |reservation|
          if reservation.id == id
            return reservation
          end
        end
      elsif date.class == Time
        # if index <= @reservations.length
        # @reservations.find do |reservation|
        re = []
        @reservations.each_with_index do |reservation, index|
          if date >= reservation.start_date && date <= reservation.end_date
            re << reservation
          end
        end
        if re.empty?
          raise ArgumentError, "There are no reservations for that date"
        else
          return re # STORED ALL THE RESERVATIONS FOR AN ESPECIFIC DATE
          # HOW DO I ACCESS THE INFO FROM SPEC?
        end
      end
    end
  end
end
