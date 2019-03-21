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

    def self.load_test_data(test_dates)
      @all_rooms = test_dates.each_with_index.map do |dates, i|
        r = Hotel::HotelLedger.new(i + 1)
        r.reserve_date_range(dates[0], dates[1])
        r
      end
    end

    def reservations_on(date)
      reservations.select do |reservation|
        (reservation[:in_date]..reservation[:out_date]).include?(date)
      end
    end

    # def all_available_rooms_on(in_date, out_date)
    #   available_rooms = (Hotel::HotelLedger.all - Hotel::HotelLedger.reservations_on(@reservation_date_range))
    # end

    def reserve_date_range(in_date, out_date)
      raise ArgumentError, "Check out date is before check in date" if out_date <= in_date
      reservation = {
        room_number: rooms.first,
        in_date: in_date,
        out_date: out_date,
      }
      @all_reservations << reservation
    end

    # def reserved_on?(in_date, out_date)
    #   overlap = (@reservation_date_range.to_a & (in_date...out_date).to_a)
    #   overlap.any?
    # end

    # def total_cost
    #   (200.00 * @reservation_date_range.to_a.length).round(2)
    # end
  end
end
