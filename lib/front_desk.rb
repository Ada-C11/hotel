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
      reserve = Hotel::Reservation.new(
        booking_ref: booking_ref,
        room_number: room_number,
        start_date: start_date,
        end_date: end_date,
        total_cost: @total_cost,
      )

      return reserve
    end

    def add_reservation(room_reservation)
      @reservations.push(room_reservation)
      puts "VVVVVVVVVVVVVV"
      puts @reservations
      puts "^^^^^^^^^^^^^^"
    end

    def get_reservation_by_date(start_date, end_date)
      reservations_by_date = []
      puts "vvvvvvvvvvvvvvvv"
      puts @reservations
      puts "^^^^^^^^^^^^^^^"
      for i in (0...@reservations.length)
        if (@reservations[i].start_date == start_date) || (@reservations[i].end_date == end_date)
          reservations_by_date.push(@reservations[i])
        end
      end
      return reservations_by_date
    end

    def is_room_available(start_date, end_date)
      puts "is_room_available:"
      reservations_at_date = get_reservation_by_date(start_date, end_date)
      puts "CURRENT ROOMS"
      puts "room_in_question: #{reservations_at_date}"
      #puts current_reservations[0].room_number
      puts "^^^^^^^^^^^^^^^"

      puts "@RESERVATIONS"
      puts "#{@reservations.length} reservations"
      puts "^^^^^^^^^^^^^^^"
      available_rooms = []
      for room_idx in (0..@all_rooms.length - 1)
        room_booked = false
        for res_idx in (0..reservations_at_date.length - 1)
          resrved_room = reservations_at_date[res_idx].room_number
          room_in_question = @all_rooms[room_idx]
          if resrved_room == room_in_question
            room_booked = true
            break
          end
        end

        if room_booked == false
          available_rooms << @all_rooms[room_idx]
        end
      end
      puts "ALL ROOMS"
      puts "#{@all_rooms}"
      puts "^^^^^^^^^^^^^^^"

      puts "AVAILABLE ROOMS"
      puts "#{available_rooms}"
      puts "^^^^^^^^^^^^^^^"

      return available_rooms
    end

    # reserved_rooms = get_reservation_by_date(start_date, end_date).map { |reservation|
    #   reservations_by_date[reservation].room_number
    # }

    # available_rooms = @all_rooms.reject { |rm_num| reserved_rooms.include? rm_num }

    # add_reservation(make_reservation(@reservations.length + 1, 1, Date.new(2019, 3, 3), Date.new(2019, 3, 15)))

    # add_reservation(Hotel.make_reservation(@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 18)))

    # add_reservation(Hotel.make_reservation(@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 17)))

    # add_reservation(Hotel.make_reservation(@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 16)))

    # add_reservation(Hotel.make_reservation(@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 15)))

    # date_reserves = get_reservation_by_date(Date.today + 1)

    # puts date_reserves[0].start_date
    # puts date_reserves[0].end_date

    # # puts @@reservations[0].total_cost
    # # puts @@reservations[1].total_cost
    # # puts @@reservations[2].total_cost
    # puts @@reservations[3].total_cost

    # puts @@reservations.length

    # for i in (0...@@reservations.length)
    #   puts @@reservations[i].end_date
    # end

  end # Class end
end # Hotel end
