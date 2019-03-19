module Hotel
  class Room
    def self.all
      return @all_rooms if @all_rooms
      @all_rooms = 20.times.map do |i|
        Hotel::Room.new(i + 1)
      end
    end

    def self.load_test_data(test_dates)
      @all_rooms = test_dates.each_with_index.map do |dates, i|
        r = Hotel::Room.new(i + 1)
        r.reserve_date_range(dates[0], dates[1])
        r
      end
    end

    def self.reservations_on(date)
      Hotel::Room.all.map do |room|
        room if room.reservation_date_range.include?(date)
      end
        .compact
    end

    # def self.all_available_rooms_on(in_date, out_date)
    #   (Hotel::Room.all - Hotel::Room.reserved_on?(in_date, out_date))
    # end

    attr_reader :reservation_date_range, :room_number

    def initialize(room_number)
      @room_number = room_number
    end

    def reserve_date_range(in_date, out_date)
      raise ArgumentError, "Check out date is before check in date" if out_date <= in_date
      @reservation_date_range = in_date...out_date
    end

    def reserved_on?(in_date, out_date)
      overlap = (@reservation_date_range.to_a & (in_date...out_date).to_a)
      overlap.any?
    end

    def all_available_rooms_on(in_date, out_date)
      (Hotel::Room.all - Hotel::Room.reservations_on(@reservation_date_range))
    end

    def total_cost
      (200.00 * @reservation_date_range.to_a.length).round(2)
    end
  end
end
