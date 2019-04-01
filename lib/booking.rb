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

    def find_room(id)
      return @rooms.find { |room| room.id == id }
    end

    def request_reservation(checkin, checkout, room_num = nil)
      Reservation.validate_dates(checkin, checkout)
      if room_num
        room = check_availability(checkin, checkout, room_num)
      else
        room = check_availability(checkin, checkout).first
      end
      reservation = Hotel::Reservation.new(checkin: checkin, checkout: checkout, room: room)
      @reservations << reservation
      room.add_reservation(reservation)
      return reservation
    end

    def check_availability(checkin, checkout, room = nil)
      unless room == nil
        room_obj = find_room(room)
        if room_obj.is_available?(checkin, checkout)
          return room_obj
        else
          raise UnavailableRoomError, 'That room is not available for those dates'
        end
      end
      
      avail_rooms = []
      @rooms.each do |room|
        if room.is_available?(checkin, checkout)
          avail_rooms << room
        end
      end

      if avail_rooms.empty?
        raise UnavailableRoomError, 'No rooms are available for those dates'
      end
      return avail_rooms
    end

    def find_reservation(date)
      return @reservations.select { |res| res.includes_date?(date) }
    end

    def get_rooms(checkin, checkout, num_rooms)
      rooms = check_availability(checkin, checkout)
      if rooms.length < num_rooms
        raise UnavailableRoomError, 'There are not enough rooms available for those dates'
      end
      return rooms[0...num_rooms]
    end

    def create_block(checkin, checkout, rooms, discounted_rate)
      new_block = Hotel::Block.new(checkin, checkout, rooms, discounted_rate)
      @blocks << new_block
      rooms.each do |room|
        room.add_block(new_block)
      end
    end
  end
end