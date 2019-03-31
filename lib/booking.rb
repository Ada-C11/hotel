require "date"
require_relative "reservation.rb"
require_relative "block.rb"

module Hotel
  class Booking
    class UnavailableRoomError < StandardError; end

    attr_accessor :rooms, :reservations, :blocks

    def initialize
      @rooms = []
      @reservations = []
      @blocks = []
    end

    def request_reservation(checkin, checkout)
      Reservation.validate_dates(checkin, checkout)
      room = check_availability(checkin, checkout).first
      reservation = Hotel::Reservation.new(checkin: checkin, checkout: checkout, room: room)
      @reservations << reservation
      room.add_reservation(reservation)
      return reservation
    end

    def check_availability(checkin, checkout)
      date_range = Hotel::Reservation.reservation_dates(checkin, checkout)
      taken_rooms = []
      date_range.each do |date|
        res_list = find_reservation(date)
        res_list.each do |res|
          taken_rooms << res.room.id
        end
      end
      taken_rooms = taken_rooms.uniq.sort!

      avail_rooms = @rooms.reject do |room|
        taken_rooms.include? room.id
      end

      if avail_rooms.empty?
        raise UnavailableRoomError, 'No rooms are available for those dates'
      end
      return avail_rooms
    end

    def find_reservation(date)
      return @reservations.select { |res| res.includes_date?(date) }
    end

    def create_block(checkin, checkout, num_rooms, discounted_rate)
      rooms = check_availability(checkin, checkout)
      if rooms.length < num_rooms
        raise UnavailableRoomError, 'There are not enough rooms available for those dates'
      end
      new_block = Hotel::Block.new(checkin, checkout, rooms[0..num_rooms], discounted_rate)
      @blocks << new_block
    end
  end
end