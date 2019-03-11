require "time"

module Hotel
  class Frontdesk
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = Hotel::Room.all_rooms
      @reservations = []
    end

    def request_reservation(name, checkin_date, num_of_nights)
      pending_reservation = Hotel::Reservation.new(name, checkin_date, num_of_nights)
      pending_reservation.room_num = rand(1..20)
      @reservations << pending_reservation
      #Hotel::Room.add_reservation()
      return pending_reservation
    end
  end
end
