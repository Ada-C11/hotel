module Hotel
  class Room
    attr_reader :room_id

    RATE = 200.freeze
    private_constant :RATE

    def initialize(room_id)
      @room_id = room_id
      @reservations = Array.new
      @block_intervals = Array.new
    end

    def reserve(reserved_dates)
      if !is_available?(reserved_dates)
        raise ArgumentError, "The room you want to reserve is not available."
      end

      r = Hotel::Reservation.new(reserved_dates, @room_id, RATE)
      @reservations << r
      return r
    end

    def reserve_block(reserved_dates, discount_rate)
      @block_intervals.each do |interval|
        if interval.equals?(reserved_dates)
          r = Hotel::Reservation.new(reserved_dates, @room_id, discount_rate)
          @reservations << r
          @block_intervals.delete(interval)
          return r
        end
      end

      raise ArgumentError, "You cannot reserve this room"
    end
    # need test: test with blocks
    def is_available?(time_interval)
      @reservations.each do |reservation|
        if reservation.overlap?(time_interval)
          return false
        end
      end

      @block_intervals.each do |interval|
        if interval.overlap?(time_interval)
          return false
        end
      end
      return true
    end

    def get_reservation_on_date(date)
      @reservations.each do |reservation|
        if reservation.has_date?(date)
          return reservation
        end
      end
      return nil
    end
    # need test: test 1: throws exception if dates are unvailable because of non-blocked reservation
    # test 2: throws exception for block reservations
    # test 3: successfully add block dates
    def block_dates(reserved_dates)
      if !is_available?(reserved_dates)
        raise ArgumentError, "You cannot block out these dates"
      end
      @block_intervals << reserved_dates
    end
  end
end