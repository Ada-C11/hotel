require "date"

module BookingSystem
  class Reservation
    attr_reader :room, :date_range, :cost

    def initialize(room:, checkin_date: nil, checkout_date: nil)
      @room = room
      unless checkin_date.instance_of?(Date) && checkout_date.instance_of?(Date) && checkout_date >= checkin_date
        raise ArgumentError.new("Check out date must be later than check in date, got check out: #{checkout_date} and check in: #{checkin_date}")
      end
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @date_range = (checkin_date...checkout_date)
    end

    def total_cost
      cost, num_of_nights = 0, 0
      num_of_nights = date_range.count
      cost = num_of_nights * room.price
      return cost 
    end
  end
end

# reservation = BookingSystem::Reservation.new(room: BookingSystem::Room.new(room_num: 1),
#                                               checkin_date: Date.new(2019, 1, 1),
#                                               checkout_date: Date.new(2019, 1, 3))

# puts "Checking total_cost #{reservation.total_cost}"