require_relative "room"
require_relative "reservation"
require "pry"

module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..20).map { |num| Hotel::Room.new(number: num) }
      @reservations = []
    end

    def request_reservation(check_in_date, check_out_date, block: false)
      rooms = available_rooms(check_in_date, check_out_date)

      raise ArgumentError, "No available rooms" if rooms.length == 0

      reservation = Hotel::Reservation.new(check_in_date: check_in_date,
                                           check_out_date: check_out_date,
                                           room: rooms.first,
                                           block: block)

      reservations << reservation
      rooms.first.add_reservation(reservation)
      # find_room(reservation.room_number).add_reservation(reservation)
      return reservation
    end

    # def find_room(room_number)
    #   rooms.find { |room| room.number == room_number }
    # end

    def reservations_by_date(date)
      reservations.find_all { |reservation| reservation.all_dates.include?(Date.parse(date)) }
    end

    def available_rooms(check_in_date, check_out_date)
      check_in_date = Date.parse(check_in_date)
      check_out_date = Date.parse(check_out_date)

      if check_in_date == check_out_date
        booking_dates = [check_in_date]
      else
        booking_dates = (check_in_date..check_out_date).to_a
      end

      # returns a list of all rooms, if no reservations have been made
      return rooms if reservations.empty?

      available = []
      availability = "yes"

      rooms.each do |room|
        room.reservations.each do |reservation|
          reservation.all_dates.each do |date|
            availability = "no" if booking_dates.include?(date)
          end
        end
        available << room if availability == "yes"
        availability = "yes"
      end

      return available
    end

    #   def request_block(number_of_rooms:, )

    #   # def available_rooms(date)

    #   # end
  end
end
