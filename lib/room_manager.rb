require_relative "reservation"
require_relative "room"

module Hotel
  class RoomManager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Room.load_all
      @reservations = Reservation.load_all
      connect_reservations
    end

    def reserve(room, check_in_date, check_out_date)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      reservation_id = @reservations.length + 1
      new_reservation = Reservation.new(
        reservation_id: reservation_id,
        room: room,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
      )
      @reservations << new_reservation
    end

    def list_reservations(date)
      self.class.validate_date(date)
      date = Date.parse(date)
      reservations = self.reservations.select do |reservation|
        date >= reservation.check_in_date && date < reservation.check_out_date
      end
      return reservations
    end

    def find_room(room_id)
      Room.validate_room_id(room_id)
      return @rooms.find { |room| room.room_id == room_id }
    end

    def self.validate_date(date)
      raise ArgumentError, "Date cannot be nil" if date == nil
      raise ArgumentError, "Date must be a String" if date.class != String
      raise ArgumentError, "Date must be in the format yyyy-mm-dd" if date !~ /^(\d{4})\-(\d{1,2})\-(\d{1,2})$/
      groups = date.match(/^(\d{4})\-(\d{1,2})\-(\d{1,2})$/)
      raise ArgumentError, "Month cannot be larger than 12" if groups[2].to_i > 12
      raise ArgumentError, "Day cannot be larger than 31" if groups[3].to_i > 31
    end

    def self.validate_date_range(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      raise ArgumentError, "Check_out_date must be after check_in_date" if end_date < start_date
    end

    private

    def connect_reservations
      @reservations.each do |reservation|
        room = find_room(reservation.room_id)
        # reservation.connect(room)
      end
    end
  end
end
