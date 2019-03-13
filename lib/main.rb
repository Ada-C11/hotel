require_relative "reservation"

module Hotel
  $all_rooms = [*(1..20)] # => makes array with elements from 1 to 20
  $reservations = [] # => stores all reservation objects

  class Main
    # attr_accessor :all_rooms, :reservations

    def self.make_reservation(booking_ref, room_number, start_date, end_date)
      reserve = Hotel::Reservation.new(booking_ref: booking_ref, room_number: room_number, start_date: start_date, end_date: end_date, total_cost: @total_cost)

      return reserve
    end

    def self.add_reservation(room_reservation)
      $reservations.push(room_reservation)
    end

    def self.get_reservation_by_date(start_date)
      reservations_by_date = []
      puts "vvvvvvvvvvvvvvvv"
      puts $reservations
      puts "^^^^^^^^^^^^^^^"
      for i in (0...$reservations.length)
        if $reservations[i].start_date == start_date
          reservations_by_date.push($reservations[i])
        end
      end
      return reservations_by_date
    end

    # add_reservation(Main.make_reservation(@reservations.length + 1, 1, Date.new(2019, 3, 9), Date.new(2019, 3, 15)))

    # add_reservation(Main.make_reservation($reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 18)))

    # add_reservation(Main.make_reservation($reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 17)))

    # add_reservation(Main.make_reservation($reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 16)))

    # add_reservation(Main.make_reservation($reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 15)))

    # date_reserves = Main.get_reservation_by_date(Date.today + 1)

    # puts date_reserves[0].start_date

    # puts $reservations[0].total_cost
    # puts $reservations[1].total_cost
    # puts $reservations[2].total_cost
    # puts $reservations[3].total_cost

    # puts $reservations.length

    # for i in (0...$reservations.length)
    #   puts $reservations[i].end_date
    # end

  end # Class end
end # Module end

# puts "#{@all_rooms}"
