
class Reservation_Manager
  attr_reader :rooms, :all_reservations

  def initialize
    @all_reservations = all_reservations || []
    @all_rooms = all_rooms
  end

  def make_reservation(reservation)
    #create a new instance of Reservation class here?
    # reservation = Reservation.new(1, "2019-03-24", "2019-03-26")

    reservation_date_range = (reservation.check_in..reservation.check_out).to_a

    # create array of available rooms
    ### FINISH THIS LOOP
    # available_rooms = []
    # rooms.each do |room_dates|
    #    if room_dates.length == 0
    #     available_rooms << room
    #    else
    #     reservation_date_range.each do |reserve_date|
    #         if reserve_date != room_date[]
    #    end
    # end

    # assign first room to reservation
    reservation.room = all_rooms.sample
    require "pry"

    all_reservations << reservation
  end

  def all_rooms
    all_rooms = []
    20.times do |i|
      room = {}
      room["room_id"] = i + 1
      room["booked_date"] = []
      all_rooms << room
    end
    return all_rooms

    #  [
    #     {room_id: 1,
    #     booking_dates: []},
    #     {room_id: 2,
    #      booking_dates: []}
    #   ]
  end

  #   def self.show_all_reservations
  #     @@all_reservations
  #   end
end
