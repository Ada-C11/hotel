module Hotel
  class Reservation
    attr_reader :room_number

    def initialize(room_number:, in_date:, out_date:, block_reservations:)
      @room_number = room_number
      @in_date = in_date
      @out_date = out_date
      @block_reservations = block_reservations
      is_valid?
    end

    def date_range
      @in_date...@out_date
    end

    def overlaps?(other_in_date, other_out_date)
      @in_date <= other_in_date && other_out_date <= @out_date
    end

    def is_valid?
      @block_reservations.each do |block_reservation|
        next unless block_reservation[:room_numbers].include?(@room_number)
        next unless overlaps?(block_reservation[:in_date], block_reservation[:out_date])
        raise ArgumentError, "Invalid reservation block"
      end
    end
  end
end
