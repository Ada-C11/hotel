
module Hotel
  class HotelLedger
    attr_reader :all_reservations

    def initialize
      @all_reservations = []
    end

    def reservations
      @all_reservations
    end

    def rooms
      [*(1..20)]
    end

    def reservations_on(in_date, out_date = nil)
      reservations.select do |reservation|
        reservation_range = (reservation[:in_date]...reservation[:out_date])
        if !out_date
          reservation_range.include?(in_date)
        else
          overlap = (reservation_range.to_a & (in_date...out_date).to_a)
          overlap.any?
        end
      end
    end

    def all_available_rooms_on(in_date, out_date)
      reserved_rooms = reservations_on(in_date, out_date).map do |reservation|
        reservation[:room_number]
      end
      available_rooms = (rooms - reserved_rooms)
    end

    def make_reservation(room_number, in_date, out_date)
      raise ArgumentError, "Check out date is before check in date" if out_date <= in_date
      raise ArgumentError, "Room is unavailable" if reservations_on(in_date, out_date).map do |reservation|
        reservation[:room_number]
      end.include?(room_number)

      reservation = {
        room_number: room_number,
        in_date: in_date,
        out_date: out_date,
      }
      @all_reservations << reservation
    end

    COST = 200

    def total_cost(room_number:, in_date:, out_date:)
      reservation_date_range = (in_date...out_date).to_a
      (COST * reservation_date_range.length).round(2)
    end
  end
end
