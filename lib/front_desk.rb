require_relative "reservation"

module Hotel
  class FrontDesk
    include Hotel

    attr_reader :all_rooms, :reservations
    attr_accessor :all_rooms, :reservations

    def initialize
      @all_rooms = [*(1..20)] # => makes array with elements from 1 to 20
      @reservations = [] # => stores all reservation objects
    end

    def all_rooms_array
      return @all_rooms
    end

    def reservations_array
      return @reservations
    end

    def make_reservation(booking_ref, room_number, start_date, end_date)
      reserve = Hotel::Reservation.new(booking_ref: booking_ref, room_number: room_number, start_date: start_date, end_date: end_date, total_cost: @total_cost)

      return reserve
    end

    def add_reservation(room_reservation)
      @reservations.push(room_reservation)
      puts "VVVVVVVVVVVVVV"
      puts @reservations
      puts "^^^^^^^^^^^^^^"
    end

    def get_reservation_by_date(date)
      reservations_by_date = []
      puts "vvvvvvvvvvvvvvvv"
      puts @reservations
      puts "^^^^^^^^^^^^^^^"
      for i in (0...@reservations.length)
        if @reservations[i].start_date == date
          reservations_by_date.push(@reservations[i])
        end
      end
      return reservations_by_date
    end

    # def is_room_available?(start_date, end_date)
    # reserved_rooms = []
    # for i in (0...reservations_by_date.length)
    #   if (reservations_by_date[i].start_date == start_date) || (reservations_by_date[i].end_date == end_date)
    #     reserved_rooms.push(reservations_by_date[i])
    #   end
    # end

    #   reserved_rooms = reservations_by_date.map {}
    #   puts "RESERVED_ROOMS"
    #   puts reserved_rooms
    #   puts "^^^^^^^^^^^^^^^"
    #   available_rooms = @all_rooms.reject { |rm_num| reserved_rooms.include? rm_num }
    #   puts "AVAILABLE_ROOMS"
    #   puts available_rooms
    #   puts "^^^^^^^^^^^^^^^"
    #   # if an existing reservations start_date matches the given date
    #   return available_rooms
    # end

    # add_reservation(Hotel.make_reservation(@@reservations.length + 1, 1, Date.new(2019, 3, 3), Date.new(2019, 3, 15)))

    # add_reservation(Hotel.make_reservation(@@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 18)))

    # add_reservation(Hotel.make_reservation(@@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 17)))

    # add_reservation(Hotel.make_reservation(@@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 16)))

    # add_reservation(Hotel.make_reservation(@@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 15)))

    # date_reserves = get_reservation_by_date(Date.today + 1)

    # puts date_reserves[0].start_date
    # puts date_reserves[0].end_date

    # puts @@reservations[0].total_cost
    # puts @@reservations[1].total_cost
    # puts @@reservations[2].total_cost
    # puts @@reservations[3].total_cost

    # puts @@reservations.length

    # for i in (0...@@reservations.length)
    #   puts @@reservations[i].end_date
    # end

  end # Class end
end # Hotel end
