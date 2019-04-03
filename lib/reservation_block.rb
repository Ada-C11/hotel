module Hotel
  class ReservationBlock
    def initialize(room_numbers:, in_date:, out_date:, discounted_percentage:, all_reservations:)
      @room_numbers = room_numbers
      @in_date = in_date
      @out_date = out_date
      @discounted_percentage = discounted_percentage
      @all_reservations = all_reservations
      is_valid?
    end

    def date_range
      @in_date...@out_date
    end

    def block_of_rooms
      @room_numbers
    end

    def discounted_rate
      1 - @discounted_percentage
    end

    def overlaps?(other_in_date, other_out_date)
      @in_date <= other_in_date && other_out_date <= @out_date
    end

    def is_valid?
      @all_reservations.each do |reservation|
        next unless block_of_rooms.include?(reservation[:room_number])
        next unless overlaps?(reservation[:in_date], reservation[:out_date])
        raise ArgumentError, "Invalid reservation block"
      end
    end
  end
end
