module Hotel
  class HotelLedger
    attr_reader :room_reservations, :block_reservations

    def initialize
      @room_reservations = []
      @block_reservations = []
    end

    def all_room_reservations
      @room_reservations
    end

    def all_block_reservations
      @block_reservations
    end

    def rooms
      [*(1..20)]
    end

    def reservations_on(in_date, out_date = nil)
      all_room_reservations.select do |reservation|
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

    def make_room_reservation(room_number, in_date, out_date)
      raise ArgumentError, "Check out date is before check in date" if out_date <= in_date
      raise ArgumentError, "Room is unavailable" if reservations_on(in_date, out_date).map do |reservation|
        reservation[:room_number]
      end.include?(room_number)

      room_reservation = {
        room_number: room_number,
        in_date: in_date,
        out_date: out_date,
      }
      @room_reservations << room_reservation
    end

    def make_block_reservation(room_numbers, in_date, out_date, discounted_percentage, room_reservations)
      block_reservation = ReservationBlock.new(
        room_numbers: room_numbers,
        in_date: in_date,
        out_date: out_date,
        discounted_percentage: discounted_percentage,
        room_reservations: @room_reservations,
      )
      @block_reservations << block_reservation
    end

    COST = 200

    def total_cost(room_number:, in_date:, out_date:)
      reservation_date_range = (in_date...out_date).to_a
      (COST * reservation_date_range.length).round(2)
    end
  end
end
