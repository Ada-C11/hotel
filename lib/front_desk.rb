require_relative "reservation"

module Hotel
  class FrontDesk
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

    def reservation_template(new_booking_ref, new_room_number, new_start_date, new_end_date)
      booking = Hotel::Reservation.new(
        booking_ref: new_booking_ref,
        room_number: new_room_number,
        start_date: new_start_date,
        end_date: new_end_date,
        total_cost: @total_cost,
      )
      return booking
    end

    def make_reservation(new_booking_ref, new_room_number, new_start_date, new_end_date)
      if @reservations.length == 0
        booking = reservation_template(new_booking_ref, new_room_number, new_start_date, new_end_date)
      else
        for i in (0...@reservations.length)
          if (@reservations[i].room_number == new_room_number)
            if ((new_start_date >= @reservations[i].start_date) && (new_start_date < @reservations[i].end_date)) ||
               ((new_end_date >= @reservations[i].end_date) && (new_end_date < @reservations[i].end_date))
              raise ArgumentError, "This room is unavailable."
            else
              booking = reservation_template(new_booking_ref, new_room_number, new_start_date, new_end_date)
            end # inner if
          else
            booking = reservation_template(new_booking_ref, new_room_number, new_start_date, new_end_date)
          end # outer if
        end # for end
      end

      return booking
    end # method end

    def add_reservation(room_reservation)
      @reservations.push(room_reservation)
    end

    def get_reservation_by_date(start_date, end_date)
      reservations_by_date = []

      for i in (0...@reservations.length)
        if (@reservations[i].start_date == start_date) || (@reservations[i].end_date == end_date)
          reservations_by_date.push(@reservations[i])
        end
      end
      return reservations_by_date
    end

    def room_availablity(start_date, end_date)
      puts "is_room_available:"

      reservations_at_date = get_reservation_by_date(start_date, end_date)

      puts "CURRENT ROOMS"
      puts "room_in_question: #{reservations_at_date}"
      puts "^^^^^^^^^^^^^^^"

      puts "@RESERVATIONS"
      puts "#{@reservations.length} reservations"
      puts "^^^^^^^^^^^^^^^"

      available_rooms = []

      for room_idx in (0..@all_rooms.length - 1)
        room_booked = false
        for res_idx in (0..reservations_at_date.length - 1)
          reserved_room = reservations_at_date[res_idx].room_number
          room_in_question = @all_rooms[room_idx]
          if (reserved_room == room_in_question)
            room_booked = true
            break
          end
        end

        if (room_booked == false)
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

    # concierge = make_reservation(1001, 3, Date.today, Date.today + 5)

  end # Class end
end # Hotel end
