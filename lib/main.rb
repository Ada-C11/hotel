require_relative 'reservation'

module Hotel
  class Main

    @all_rooms = [*(1..20)] # => makes array with elements from 1 to 20
    @reservations = []

    def self.make_reservation (bk, rn, sd, ed)
     reserve = Hotel::Reservation.new(booking_ref: bk,room_number: rn, start_date: sd, end_date: ed, total_cost: @total_cost)

     return reserve
    end

    def self.add_reservation(room_reservation)
      @reservations.push(room_reservation)
    end

    # add_reservation(Main.make_reservation(@reservations.length + 1, 1, Date.new(2019, 3, 9), Date.new(2019, 3, 15)))

    # add_reservation(Main.make_reservation(@reservations.length + 1, 2, Date.today + 1, Date.new(2019, 3, 18)))

    # puts @reservations[1].total_cost

    puts @reservations.length
  end # Class end
end # Module end

