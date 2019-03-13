module Hotel
  class Reservation
    attr_reader :room, :start_date, :end_date

    def initialize(room, start_date, end_date, total_cost)
      @room = room
      @start_date = start_date
      @end_date = end_date
      @total_cost = total_cost
    end

    def make_a_reservation(date_range)
      completed_reservation = {
        room: room_number,
        date: date_range,
        cost: total_cost,
      }
        .make_a_reservation(completed_reservations)
    end

    def find_a_room(date_range)
      begin
        @room.available?(status)

        raise ArgumentError, "Room is unavailable for this range."
      rescue
      end
    end
  end
end
