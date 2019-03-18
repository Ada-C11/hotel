require 'date'
require 'pry'
require_relative 'rooms_manager'
require_relative 'reservations_child'
require_relative 'booking_manager'

module Hotel
  class ReservationsManager
    attr_reader :rooms, :reservations, :reservation_id, :occupied

    def initialize
      @rooms = load_rooms
      @reservations = {}
      @reservation_id = (1..300).to_a
      @occupied = {}
    end

    def load_rooms
      rooms = {}
      (1..20).each do |room_number, price_per_night|
        rooms[room_number] = Hotel::Room.new(room_number, price_per_night)
      end
      rooms
    end

    def list_rooms
      @rooms.values
    end

    def make_reservation(room_id, start_date, end_date)
      raise ArgumentError, "Room number doesn't exist" unless rooms.key?(room_id)

      room = @rooms[room_id]
      unless list_of_available_rooms(start_date, end_date).include?(room)
        raise ArgumentError, 'Room is not currently available'
      end

      reservation_data = {
        id: @reservation_id.shift,
        room: room,
        start_date: start_date,
        end_date: end_date
      }

      new_reservation = Hotel::Reservations.new(reservation_data)
      @reservations[new_reservation.id] = new_reservation
      new_reservation
    end

    def find_reservation(date)
      reservation_found = @reservations.select { |_id, reservation| reservation.start_date <= date && reservation.end_date > date }.values
      reservation_found
    end

    def reservation_total_cost(reservation_id)
      total_to_pay = @reservations[reservation_id].reservation_cost
      total_to_pay
    end

    def list_of_reservations(check_in, check_out)
      reserved_rooms = []
      (check_in..check_out).each do |date|
        reserved_rooms += find_reservation(date).flat_map(&:room)
      end
      reserved_rooms.uniq
    end

    def list_of_available_rooms(check_in, check_out)
      available_rooms = @rooms.values - list_of_reservations(check_in, check_out - 1)
      available_rooms
    end
  end
end
