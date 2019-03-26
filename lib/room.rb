module Hotel
  class Room
    attr_reader :room_id

    RATE = 200
    private_constant :RATE

    def initialize(room_id)
      @room_id = room_id
      @reservations = Array.new
      @block_intervals = Array.new
    end

    def reserve(reserved_dates)
      if !is_available?(reserved_dates)
        raise RoomNotAvailableError, "The room you want to reserve is not available."
      end

      r = Reservation.new(reserved_dates, @room_id, RATE)
      @reservations << r
      return r
    end

    def reserve_block(reserved_dates, discount_rate)
      @block_intervals.each do |interval|
        if interval.equals?(reserved_dates)
          r = Reservation.new(reserved_dates, @room_id, discount_rate)
          @reservations << r
          @block_intervals.delete(interval)
          return r
        end
      end

      raise RoomNotAvailableError, "You cannot reserve this room"
    end

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

    def block_dates(reserved_dates)
      if !is_available?(reserved_dates)
        raise RoomNotAvailableError, "You cannot block out these dates"
      end
      @block_intervals << reserved_dates
    end

    def has_blocked_dates?(time_interval)
      @block_intervals.each do |interval|
        if interval.equals?(time_interval)
          return true
        end
      end
      return false
    end

    def is_available_in_block?(time_interval)
      @block_intervals.each do |interval|
        if interval.equals?(time_interval)
          return true
        end
      end
      return false
    end
  end
end
