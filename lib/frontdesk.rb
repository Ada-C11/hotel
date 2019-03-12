require "time"

module Hotel
  class Frontdesk
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = Frontdesk.all_rooms
      @reservations = []
    end

    def request_reservation(name, checkin_date, num_of_nights)
      pending_reservation = Hotel::Reservation.new(name, checkin_date, num_of_nights)
      pending_reservation.room_num = rand(1..20)
      @reservations << pending_reservation
      #Hotel::Room.add_reservation()
      return pending_reservation
    end

    def find_reservation_by_date(date)
      reservations_by_date = @reservations.find_all { |reservation| reservation.reserved_nights.include?(Date.parse(date)) }
      if reservations_by_date.length == 0
        return nil
      else
        return reservations_by_date
      end
    end

    private

    def self.all_rooms
      room_list = []
      counter = 0
      20.times do
        room = Room.new(counter + 1)
        counter += 1
        room_list << room
      end
      return room_list
    end
  end
end
