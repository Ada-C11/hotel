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

    def create_reservation(start_date, end_date, room_selected)
      begin
        rooms_available = find_available_rooms(start_date, end_date)
      rescue ArgumentError
        if rooms.include?(room_selected)
          room = room_selected
        else
          raise ArgumentError, "The room number is not valid"
        end
      else
        if rooms_available.include?(room_selected)
          room = room_selected
        else
          raise ArgumentError, "The room number is not available"
        end
      end
      id = @reservations.length + 1
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
        raise ArgumentError, "Invalid reservation id"
      end
    end

    def find_reservation_by_date(start_date_find, end_date_find)
      if start_date_find.class == Time ## DO I NEED TO VALIDATE THIS? IF SO, DO I NEED TO DO THAT HERE?
        reservations_found = []

        @reservations.each_with_index do |reservation, index|
          unless reservation.start_date >= end_date_find || reservation.end_date <= start_date_find
            reservations_found << reservation
          end
        end

        if reservations_found.empty?
          raise ArgumentError, "There are no reservations for that date"
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
  end
end
