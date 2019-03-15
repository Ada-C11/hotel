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

    def create_reservation(start_date, end_date) # TO CONSIDER should I parse the dates here??? not when I'm creating the reservation in the specs??
      id = @reservations.length + 1
      room = rooms.sample
      new_reservation = Reservation.new(id, start_date, end_date, room)
      @reservations << new_reservation
      return new_reservation
    end

    def find_reservation_by_id(id:)
      index = 0
      if id.class == Integer
        @reservations.find do |reservation|
          if reservation.id == id
            return reservation
          end
        end
      end
    end

    # def find_reservation_by_date(date: nil)
    def find_reservation_by_date(start_date_find, end_date_find)
      if start_date_find.class == Time ## DO I NEED TO VALIDATE THIS? IF SO, DO I NEED TO DO THAT HERE?
        reservations_found = []
        @reservations.each_with_index do |reservation, index|
          # if date >= reservation.start_date && date <= reservation.end_date
          if start_date_find >= reservation.start_date && end_date_find <= reservation.end_date ## IT WILL BE FREE IN THE CHECKOUT DATE SO I'M NOT RETURNING THAT... DOES IT AFFECT ANY OF THE
            # CALCULATIONS FOR DAYS??
            reservations_found << reservation
          elsif start_date_find <= reservation.start_date && end_date_find == reservation.end_date
            reservations_found << reservation
          elsif start_date_find == reservation.start_date && end_date_find >= reservation.end_date
            reservations_found << reservation
          end
        end ## SO FAR RETURNING THE OCCUPIED ROOMS ---> TODO: SUBTRACT THE VALUES IN THE reservations_found array FROM THE ROOM NUMBERS
        if reservations_found.empty?
          raise ArgumentError, "There are no reservations for that date"
          # elsif reservations_found.length == 1
          #   return reservations_found[0] #RIGHT NOW RETURNING THE OBJECT WHEN THERE IS JUST ONE MATCH
          #   # RECONSIDER THIS IN THE FUTURE...
        else
          return reservations_found
        end
      end
    end

    def find_available_rooms(start_date, end_date)
      reserved_rooms = find_reservation_by_date(start_date, end_date) ## MODIFY find_reservation_by_date to recieve input two dates
      reserved_rooms_numbers = []
      reserved_rooms.each do |room|
        reserved_rooms_numbers << room.room_number
      end
      available_rooms = rooms - reserved_rooms_numbers
      return available_rooms
    end

    # I can view a list of rooms that are not reserved for a given date range,
    # so that I can see all available rooms for that day

    # find all the reservations by date
    # Then collect the number of the rooms reserved (maybe the range of dates for the reservations for each room, why though?)
    #     Modify find_reservation_by_date method to take in a range rather that just a date
    #     Create a method find_available_rooms
    #         Invoke find_reservation_by_date range to get an array of reservations
    #         From the array obtained filter the rooms and maybe the dates...
    #         Return an array with the information collected OK
    # I can reserve an available room for a given date range
    # I want an exception raised if I try to reserve a room that is unavailable
    # for a given day, so that I cannot make two reservations for the same room that overlap by date

    # Details
    # A reservation is allowed start on the same day that another reservation for the same room ends
  end
end
